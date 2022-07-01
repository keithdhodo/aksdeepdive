# Azure Subscription
$subscriptionId = "efdefaf7-e7a2-4706-8457-484103773250"

# general variables
$resourceGroupName = "acg_aks_demo"
$location = "westus2"

# Azure Container Registry Variables
$acrName="aksdeepdive24"
$acrSku="Basic"

# Service Principal Variables (retrieved from SPN Creation)
$spnAppId="8bca0d0e-9bb7-4a57-9bd1-d1659c4ed8fc"
$spnRole="acrpull"
# this value is the id returned from ACR creation
$spnScope="/subscriptions/efdefaf7-e7a2-4706-8457-484103773250/resourceGroups/acg_aks_demo/providers/Microsoft.ContainerRegistry/registries/aksdeepdive24"

az login

WRITE-HOST "Logged in to Azure!!!"

# set to <your account id>
az account set --subscription $subscriptionId

# create resource group
az group create -n $resourceGroupName -l $location

# create spn
az ad sp create-for-rbac --skip-assignment

# create Azure Container Registry
az acr create --resource-group $resourceGroupName -n $acrName --sku $acrSku --admin-enabled true

# assign Service Principal to Role so it can access ACR
az role assignment create --assignee $spnAppId --role $spnRole --scope $spnScope

# Container Registries and Container Instances 8:08
