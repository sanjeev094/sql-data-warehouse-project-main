
#!/usr/bin/env bash

# Start SQL Server in Docker on Ubuntu for the Data Warehouse project.

CONTAINER="sql-dwh-project"
PKG="dwh_project"
PASSWORD="${MSSQL_SA_PASSWORD:-SqlServer!2026}"

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
PKG_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"

pause() {
    echo
    read -r -n 1 -s -p "Press any key to close..."
    echo
}

# Check whether Docker is available and running.
if ! command -v docker >/dev/null 2>&1; then
    echo "Docker is not installed. Install Docker Engine and Docker Compose first."
    exit 1
fi

if ! docker info >/dev/null 2>&1; then
    echo "Docker is not running or your user cannot access it."
    echo "Start Docker with: sudo systemctl start docker"
    echo "If required, configure Docker permissions for your user."
    exit 1
fi

# Check that the datasets exist.
if [[ ! -d "$PKG_DIR/01_datasets" ]]; then
    echo "Dataset folder not found: $PKG_DIR/01_datasets"
    echo "Check the location of this script inside the project."
    exit 1
fi

# Reuse a running SQL Server container if port 1433 is already published.
TARGET="$(docker ps --filter publish=1433 --format '{{.Names}}' | head -n 1)"

if [[ -z "$TARGET" ]]; then
    echo "Starting SQL Server in Docker..."

    cd "$SCRIPT_DIR" || exit 1

    if ! docker compose up -d; then
        echo "Failed to start Docker Compose services."
        pause
        exit 1
    fi

    TARGET="$CONTAINER"
else
    echo "SQL Server is already running in container: $TARGET"
fi

# Execute SQL commands inside the SQL Server container.
sql() {
    docker exec "$TARGET" \
        /opt/mssql-tools18/bin/sqlcmd \
        -S localhost \
        -U sa \
        -P "$PASSWORD" \
        -C -b -h -1 \
        -Q "$1" 2>/dev/null
}

# Wait for SQL Server to become ready.
printf "Waiting for SQL Server "

READY=0

for ((i = 1; i <= 120; i++)); do
    if sql "SELECT 1" >/dev/null; then
        READY=1
        break
    fi

    printf "."
    sleep 2
done

echo

if [[ "$READY" -ne 1 ]]; then
    echo "SQL Server did not respond."
    echo "Check the container logs with:"
    echo "docker logs $TARGET"
    pause
    exit 1
fi

# Create the dataset directory inside the container.
if ! docker exec -u root "$TARGET" mkdir -p "/sql/$PKG"; then
    echo "Failed to create the dataset directory."
    exit 1
fi

# Copy the source datasets into the container.
if ! docker cp "$PKG_DIR/01_datasets" "$TARGET:/sql/$PKG/"; then
    echo "Failed to copy the datasets."
    exit 1
fi

# Set appropriate ownership for SQL Server.
if ! docker exec -u root "$TARGET" \
    chown -R mssql:root "/sql/$PKG"; then
    echo "Warning: Could not update directory ownership."
fi

echo
echo "SQL Server is ready!"
echo "Datasets copied to: /sql/$PKG/01_datasets/"
echo
echo "Connect using these settings:"
echo "Server: localhost"
echo "Port: 1433"
echo "Username: sa"
echo "Password: Use your configured SQL Server password"
echo
echo "Next steps:"
echo "1. Connect using VS Code or another SQL client."
echo "2. Execute 03_scripts/init_database.sql."
echo "3. Run the Bronze, Silver, and Gold scripts in order."

pause
