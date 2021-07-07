#!/bin/bash

RESOURCE_GROUP_NAME="${1-example-centralus}"

echo "RESOURCE_GROUP_NAME.: ${RESOURCE_GROUP_NAME}"

set -e

if ! which az &> /dev/null; then
  echo "azure client not installed"
  exit 1
fi

if ! which jq &> /dev/null; then
  echo "jq not installed"
  exit 1
fi

QUERY=$(printf "[?name=='%s']" ${RESOURCE_GROUP_NAME?})

az group list \
  --output table \
  --query "${QUERY?}"

echo ""

az network vnet list \
  --output table

echo ""

for VNET in $(az network vnet list --query '[].name' | jq '.[]' -r); do
   echo "vnet: ${VNET?}"
   echo ""

   az network vnet subnet list \
     --vnet-name "${VNET?}" \
     --resource-group "${RESOURCE_GROUP_NAME?}" \
     --output table

   echo ""
done

echo ""
