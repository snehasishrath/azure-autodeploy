param (
  [string]$Environment = "dev",
  [string]$ResourceGroup = "rg-autodeploy",
  [string]$Location = "westeurope"
)

$ParamsFile = "./bicep/parameters/$Environment.json"

Write-Host "🔍 Validating deployment with environment: $Environment"

az deployment group validate `
  --resource-group $ResourceGroup `
  --template-file ./bicep/main.bicep `
  --parameters @$ParamsFile `
  --output table

if ($LASTEXITCODE -eq 0) {
  Write-Host "✅ Validation successful. Deploying..."

  az deployment group create `
    --resource-group $ResourceGroup `
    --template-file ./bicep/main.bicep `
    --parameters @$ParamsFile `
    --output table
} else {
  Write-Error "❌ Validation failed. Check your parameters and try again."
}