# Your Solution

set -u # or set -o nounset
: "$CONTAINER_REGISTRY"
: "$VERSION"

docker build -t book-catalog-service:latest ./book_catalog
docker build -t inventory-management-service:latest ./inventory_management