# Solution Overview: Automated Data Tiering

The problem is the high cost of storing millions of billing records in Azure Cosmos DB, where most are rarely accessed. Our solution moves this "cold" data to Azure Blob Storage to reduce cost while maintaining availability.

## Data Flow

### Write Path (New Records)
1.  A client POSTs to the `WriteBillingRecord` API.
2.  The function writes the record directly to Azure Cosmos DB.

### Read Path (Accessing Records)
1.  A client GETs a record ID from the `ReadBillingRecord` API.
2.  The function first queries Cosmos DB. If found, the record is returned.
3.  If not found, the function queries Blob Storage. If found, it's returned.
4.  Otherwise, a `404 Not Found` is returned.

### Archival Path (Automated Tiering)
1.  The `ArchiveOldRecords` timer function runs daily.
2.  It finds records in Cosmos DB older than 90 days.
3.  It copies each record to Blob Storage and, upon success, deletes the original from Cosmos DB.
