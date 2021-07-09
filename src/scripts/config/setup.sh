#!/bin/bash

RESOURCE_GROUP_NAME="iac"
RESOURCE_GROUP_LOCATION="centralus"
STORAGE_ACCOUNT_NAME="terraform${RANDOM}"
CONTAINER_NAME="state"

# Create Resource Group
az group create \
  --name ${RESOURCE_GROUP_NAME?} \
  --location ${RESOURCE_GROUP_LOCATION?}

# Create Storage Account
az storage account create \
  --resource-group ${RESOURCE_GROUP_NAME?} \
  --name ${STORAGE_ACCOUNT_NAME?} \
  --sku "Standard_LRS" \
  --encryption-services "blob"

# Get Storage Account Key
ACCOUNT_KEY=$(az storage account keys list \
  --resource-group ${RESOURCE_GROUP_NAME?} \
  --account-name ${STORAGE_ACCOUNT_NAME?} \
  --query '[0].value' \
  --output tsv)

# Create Blob Container
az storage container create \
  --name ${CONTAINER_NAME?} \
  --account-name ${STORAGE_ACCOUNT_NAME?} \
  --account-key ${ACCOUNT_KEY?}

echo ""
echo "STORAGE_ACCOUNT_NAME.: ${STORAGE_ACCOUNT_NAME?}"
echo "CONTAINER_NAME.......: ${CONTAINER_NAME?}"
echo "ACCOUNT_KEY..........: ${ACCOUNT_KEY?}"
echo ""
