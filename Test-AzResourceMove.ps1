# Author: @seanvoda
# Description: Checks if a resource can be moved to another subscription
# Version: 1.0.0
# Date: 2023-04-13

$nonMovableResourcesJsonPath = ".\NonMovableResources.json"
$nonMovableResourceTypes = (Get-Content $nonMovableResourcesJsonPath | ConvertFrom-Json).ResourceTypes

$sourceSubscriptionId = "tenantId"

Connect-AzAccount

Set-AzContext -SubscriptionId $sourceSubscriptionId

$resourceGroups = Get-AzResourceGroup

$results = @()

foreach ($resourceGroup in $resourceGroups) {
    Write-Host "Checking resource group: $($resourceGroup.ResourceGroupName)"

    $resources = Get-AzResource -ResourceGroupName $resourceGroup.ResourceGroupName

    foreach ($resource in $resources) {
        if ($nonMovableResourceTypes -contains $resource.ResourceType) {
            Write-Host "Resource $($resource.ResourceId) is a non-moveable resource type" -ForegroundColor Yellow

            $result = New-Object -TypeName PSObject -Property @{
                ResourceId          = $resource.ResourceId
                ResourceType        = $resource.ResourceType
                ResourceGroupName   = $resourceGroup.ResourceGroupName
                CanBeMoved          = $false
            }

            $results += $result
        }
        else {
            $result = New-Object -TypeName PSObject -Property @{
                ResourceId          = $resource.ResourceId
                ResourceType        = $resource.ResourceType
                ResourceGroupName   = $resourceGroup.ResourceGroupName
                CanBeMoved          = $true
            }

            $results += $result
        }
    }
}

$results | Select-Object ResourceId, ResourceType, ResourceGroupName, CanBeMoved | Export-Csv -Path "c:\temp\AzResourceMoveCheck.csv" -NoTypeInformation
