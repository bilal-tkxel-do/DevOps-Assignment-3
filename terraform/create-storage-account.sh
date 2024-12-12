#!/bin/bash

RESOURCE_GROUP_NAME="state-resource-group"
LOCATION="East US"
STORAGE_ACCOUNT_NAME="statestorageacctbilal"
CONTAINER_NAME="tfstate"
STATE_FILE_NAME="terraform.tfstate"

echo "Creating Resource Group..."
az group create --name "$RESOURCE_GROUP_NAME" --location "$LOCATION"

echo "Creating Storage Account..."
az storage account create \
  --name "$STORAGE_ACCOUNT_NAME" \
  --resource-group "$RESOURCE_GROUP_NAME" \
  --location "$LOCATION" \
  --sku Standard_LRS \
  --kind StorageV2

echo "Fetching Storage Account connection string..."
STORAGE_ACCOUNT_KEY=$(az storage account keys list \
  --resource-group "$RESOURCE_GROUP_NAME" \
  --account-name "$STORAGE_ACCOUNT_NAME" \
  --query '[0].value' \
  --output tsv)

echo "Creating Blob Container..."
az storage container create \
  --name "$CONTAINER_NAME" \
  --account-name "$STORAGE_ACCOUNT_NAME" \
  --account-key "$STORAGE_ACCOUNT_KEY"

echo "Resources created successfully!"
echo "Resource Group: $RESOURCE_GROUP_NAME"
echo "Storage Account: $STORAGE_ACCOUNT_NAME"
echo "Blob Container: $CONTAINER_NAME"
echo "State File: $STATE_FILE_NAME"

