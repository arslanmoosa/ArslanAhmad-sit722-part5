# Your Solution
set -u # or set -o nounset
: "$CONTAINER_REGISTRY"
: "$VERSION"
: "$REGISTRY_UN"
: "$REGISTRY_PW"

docker login ampart5.azurecr.io -u ampart5 -p JeLcwwrbB/TQFuqivqZgeKb174S1g78aijFVVphfnI+ACRBnZJQD
docker images
docker tag book-catalog-service ampart5.azurecr.io/book-catalog-service

docker tag inventory-management-service ampart5.azurecr.io/inventory-management-service
docker push ampart5.azurecr.io/book-catalog-service:latest
docker push ampart5.azurecr.io/inventory-management-service:latest