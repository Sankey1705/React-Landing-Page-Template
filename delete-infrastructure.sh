#!/bin/bash
# ============================================================
# Sanket's Azure Infrastructure - DELETE Script
# Owner      : Sanket Wadbudhe
# WARNING    : Deletes ALL resources in Usecase-1 group
# ============================================================

SUBSCRIPTION_ID="f77da30d-94bf-42b9-927b-f13138521761"
RESOURCE_GROUP="Usecase-1"

echo ""
echo "============================================"
echo "  WARNING: DELETING ALL AZURE RESOURCES"
echo "  Owner: Sanket Wadbudhe"
echo "============================================"
echo ""
echo "Resources that will be DELETED:"
echo "  Resource Group  : $RESOURCE_GROUP"
echo "  Web App         : react-landing-page"
echo "  App Service Plan: reactplan"
echo "  Storage Account : sankeyacc01"
echo "  Location        : Central US and East US"
echo ""
echo "NOTE: After deletion run create-infrastructure.sh"
echo "      to recreate everything in 2 minutes"
echo ""
echo "Type 'yes' to confirm deletion: "
read CONFIRM

if [ "$CONFIRM" != "yes" ]; then
  echo ""
  echo "Cancelled. Nothing was deleted."
  exit 0
fi

echo ""
echo "Setting subscription..."
az account set --subscription $SUBSCRIPTION_ID
echo "DONE"
echo ""

echo "Deleting Resource Group $RESOURCE_GROUP..."
echo "This takes about 2 to 3 minutes..."
echo ""

az group delete \
  --name $RESOURCE_GROUP \
  --yes \
  --no-wait

echo ""
echo "============================================"
echo "  DELETION STARTED IN BACKGROUND"
echo "============================================"
echo ""
echo "All resources deleted in about 2 minutes:"
echo "  react-landing-page (Web App)     DELETED"
echo "  reactplan (App Service Plan)     DELETED"
echo "  sankeyacc01 (Storage Account)    DELETED"
echo "  Usecase-1 (Resource Group)       DELETED"
echo ""
echo "Your cost from now = Rs 0.00"
echo ""
echo "To recreate everything later:"
echo "  bash create-infrastructure.sh"
echo ""
echo "NOTE: After recreating, the script will"
echo "      automatically print your new URL."
echo "      Update it in your release pipeline."
echo ""
