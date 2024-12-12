#!/bin/bash

RESOURCE_GROUP_NAME="state-resource-group"  

echo "Deleting Resource Group..."
az group delete \
  --name "$RESOURCE_GROUP_NAME" \
  --yes \
  --no-wait

echo "All resources have been scheduled for deletion."

