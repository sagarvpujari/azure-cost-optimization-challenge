using namespace System.Net

param($Request, $TriggerMetadata)

$recordId = $TriggerMetadata.BindingData.id
Write-Host "Processing read request for record ID: $recordId"

if (-not $recordId) {
    Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
        StatusCode = [HttpStatusCode]::BadRequest; Body = "Please provide a record ID."
    }); return
}

$record = $null

# --- Step 1: Check Hot Tier (Simulated) ---
Write-Host "Checking Hot Tier (Cosmos DB) for: $recordId"
if ($recordId -like "*recent*") {
    $record = @{ id = $recordId; data = "This is a recent record from Cosmos DB." } | ConvertTo-Json
}

# --- Step 2: Check Cold Tier if not found (Simulated) ---
if (-not $record) {
    Write-Host "Not in Hot Tier. Checking Cold Tier (Blob Storage) for: $recordId"
    if ($recordId -like "*old*") {
        $record = @{ id = $recordId; data = "This is an old record from Blob Storage." } | ConvertTo-Json
    }
}

# --- Step 3: Prepare Response ---
if ($record) {
    $statusCode = [HttpStatusCode]::OK
    $responseBody = $record
} else {
    $statusCode = [HttpStatusCode]::NotFound
    $responseBody = "Record with ID '$recordId' not found."
}

Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
    StatusCode = $statusCode; Body = $responseBody; Headers = @{"Content-Type" = "application/json"}
})
