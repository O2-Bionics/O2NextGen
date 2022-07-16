# https://docs.microsoft.com/en-us/azure/azure-resource-manager/troubleshooting/error-sku-not-available?tabs=azure-cli
az vm list-skus --location centralus --size Standard_D --all --output table
