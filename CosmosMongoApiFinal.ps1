#az login

# az account list
az account set -s  "29ca1c13-eee4-43a6-be9a-f49a867f2d88"

$resourceGroupName = "testo23v3"
$location = 'westeurope'

# accont name must be unique globally.
$accountName = "cosmvatahidb2"

$databaseName = 'hidb-database-test'

$collectionName1 = 'hearingInstruments'
$shardKey1 = 'hiTypeUri'

$collectionName2 = 'querySets'
$shardKey2 = 'querySetId'

$collectionName3 = 'savedQuery'
$shardKey3 = 'queryName'

# $isGroupExist = az group list --query "[?name=='$resourceGroupName'].name" -o tsv

Write-Output("Starting...")

az group create --name $resourceGroupName --location $location
Write-Output("Resource group created.")

az cosmosdb create -n $accountName -g $resourceGroupName --kind MongoDB --default-consistency-level Eventual --locations regionName=$location failoverPriority=0 isZoneRedundant=False
Write-Output("Cosmosdb account created.")

az cosmosdb mongodb database create -a $accountName -g $resourceGroupName -n $databaseName --throughput 400
Write-Output("Cosmosdb with mongo api created.")

az cosmosdb mongodb collection create -a $accountName -g $resourceGroupName -d $databaseName -n $collectionName1 --shard $shardKey1 
Write-Output("Collection1 created.")

az cosmosdb mongodb collection create -a $accountName -g $resourceGroupName -d $databaseName -n $collectionName2 --shard $shardKey2
Write-Output("Collection2 created.")

az cosmosdb mongodb collection create -a $accountName -g $resourceGroupName -d $databaseName -n $collectionName3 --shard $shardKey3
Write-Output("Collection3 created.")
