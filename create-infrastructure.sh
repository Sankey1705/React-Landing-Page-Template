#!/bin/bash
# ============================================================
# Sanket's Azure Infrastructure - CREATE Script
# Owner      : Sanket Wadbudhe
# Email      : sanketwadbudhe1234@gmail.com
# DevOps Org : dev.azure.com/Sankeyyyy
# GitHub     : Sankey1705
# UC1        : React App to Azure App Service
# ============================================================

set -e

SUBSCRIPTION_ID="f77da30d-94bf-42b9-927b-f13138521761"
RESOURCE_GROUP="Usecase-1"
LOCATION_APP="centralus"
LOCATION_STORAGE="eastus"
PLAN_NAME="reactplan"
APP_NAME="react-landing-page"
RUNTIME="NODE:18-lts"
STORAGE_ACCOUNT="sankeyacc01"
STARTUP_CMD="pm2 serve /home/site/wwwroot --no-daemon --spa"

echo ""
echo "============================================"
echo "  Sanket Azure Infrastructure Setup"
echo "  UC1: React App to Azure App Service"
echo "============================================"
echo ""

echo "[1/8] Setting subscription..."
az account set --subscription $SUBSCRIPTION_ID
echo "DONE: Subscription set to Azure subscription 1"
echo ""

echo "[2/8] Creating Resource Group..."
az group create \
  --name $RESOURCE_GROUP \
  --location $LOCATION_APP \
  --output none
echo "DONE: Resource Group = $RESOURCE_GROUP in Central US"
echo ""

echo "[3/8] Creating App Service Plan F1 Free..."
az appservice plan create \
  --name $PLAN_NAME \
  --resource-group $RESOURCE_GROUP \
  --location $LOCATION_APP \
  --sku F1 \
  --is-linux \
  --output none
echo "DONE: App Service Plan = $PLAN_NAME (F1 Free - Rs 0 cost)"
echo ""

echo "[4/8] Creating Web App..."
az webapp create \
  --name $APP_NAME \
  --resource-group $RESOURCE_GROUP \
  --plan $PLAN_NAME \
  --runtime $RUNTIME \
  --output none
echo "DONE: Web App = $APP_NAME"
echo ""

echo "[5/8] Setting React startup command..."
az webapp config set \
  --name $APP_NAME \
  --resource-group $RESOURCE_GROUP \
  --startup-file "$STARTUP_CMD" \
  --output none
echo "DONE: Startup command set for React SPA"
echo ""

echo "[6/8] Creating Storage Account..."
az storage account create \
  --name $STORAGE_ACCOUNT \
  --resource-group $RESOURCE_GROUP \
  --location $LOCATION_STORAGE \
  --sku Standard_LRS \
  --kind StorageV2 \
  --output none
echo "DONE: Storage Account = $STORAGE_ACCOUNT in East US"
echo ""

echo "[7/8] Verifying all resources created..."
az resource list \
  --resource-group $RESOURCE_GROUP \
  --output table
echo ""

echo "[8/8] Fetching your actual live URL..."
ACTUAL_URL=$(az webapp show \
  --name $APP_NAME \
  --resource-group $RESOURCE_GROUP \
  --query defaultHostName \
  --output tsv)
echo "DONE: URL fetched successfully"
echo ""

echo "============================================"
echo "  ALL RESOURCES CREATED SUCCESSFULLY"
echo "============================================"
echo ""
echo "Resource Summary:"
echo "  Subscription    : Azure subscription 1"
echo "  Resource Group  : $RESOURCE_GROUP (Central US)"
echo "  App Service Plan: $PLAN_NAME (F1 Free)"
echo "  Web App         : $APP_NAME"
echo "  Storage Account : $STORAGE_ACCOUNT (East US)"
echo ""
echo "============================================"
echo "  YOUR LIVE APP URL (copy this):"
echo "  https://$ACTUAL_URL"
echo "============================================"
echo ""
echo "NEXT STEPS:"
echo "1. Copy the URL above"
echo "2. Go to dev.azure.com/Sankeyyyy"
echo "3. ReactAppServiceDemo > Releases"
echo "4. Create new release > Deploy to Dev"
echo "5. Wait 2 minutes > open URL > site is live!"
echo ""
echo "COST SUMMARY:"
echo "  App Service Plan (F1) : FREE"
echo "  Web App               : FREE"
echo "  Storage Account       : Rs 0.15 per month"
echo "  Azure DevOps          : FREE"
echo "  TOTAL                 : Nearly ZERO"
