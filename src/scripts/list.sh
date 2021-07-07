#!/bin/bash

az group list \
  --output table \
  --query "[?name=='example-centralus']"

echo ""

az network vnet list \
  --output table

echo ""

for VNET in $(az network vnet list --query '[].name' | jq '.[]' -r); do
   echo "vnet: ${VNET?}"
   echo ""

   az network vnet subnet list \
     --vnet-name "${VNET?}" \
     --resource-group "example-centralus" \
     --output table

   echo ""
done

echo ""
