using namespace System.Net

param($Request, $TriggerMetadata)

$req_body = $Request.Body

if (-not $req_body) {
    $status = [HttpStatusCode]::BadRequest
    $body = "Request body must contain a valid billing record."
} else {
    Write-Host "Received new record. Writing to Cosmos DB (Hot Tier)."
    Push-OutputBinding -Name 'billingRecordOut' -Value $req_body
    $status = [HttpStatusCode]::Created
    $body = "Record created successfully in the hot tier."
}

Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
    StatusCode = $status
    Body = $body
})
