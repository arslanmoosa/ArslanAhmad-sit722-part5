set -euo pipefail


az login
az acr login -n ampart4
echo "login successful"
az aks get-credentials --resource-group deakinuni --name amkubpart4 --overwrite-existing
echo "Connected to azure kubernetes "
docker images
envsubst < ./scripts/kubernetes/deployment.yaml | kubectl apply -f -
echo "applied"
echo "---------------------------------"
echo "repository table"
az acr repository list --name ampart4 --output table
kubectl config current-context
echo "Delaying 20 seconds to get the deployments done"
sleep 20

kubectl get pods

kubectl get services
kubectl get deployments
sleep 20
echo "IPs"

BOOK_CATALOG_IP=$(kubectl get service book-catalog -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
INVENTORY_MANAGEMENT_IP=$(kubectl get service inventory-management -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
BOOK_CATALOG_PORT=$(kubectl get service book-catalog -o jsonpath='{.spec.ports[0].port}')
INVENTORY_MANAGEMENT_PORT=$(kubectl get service inventory-management -o jsonpath='{.spec.ports[0].port}')
BOOK_CATALOG_URL="http://$BOOK_CATALOG_IP:$BOOK_CATALOG_PORT/docs"
INVENTORY_MANAGEMENT_URL="http://$INVENTORY_MANAGEMENT_IP:$INVENTORY_MANAGEMENT_PORT/docs"
echo BOOK CATALOG URL = "http://$BOOK_CATALOG_IP:$BOOK_CATALOG_PORT/docs"
echo INVENTORY MANAGEMENT URL = "http://$INVENTORY_MANAGEMENT_IP:$INVENTORY_MANAGEMENT_PORT/inventories"
