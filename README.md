# Cost Optimization Challenge: Managing Billing Records

This repository contains the proposed PowerShell-based solution for the Azure serverless cost optimization challenge. The goal is to reduce costs by archiving billing records older than three months from Cosmos DB to a cheaper storage tier.

## Proposed Solution: Data Tiering

The solution implements an automated data tiering strategy using Azure Functions written in PowerShell.

*   **Hot Tier (Azure Cosmos DB):** Stores recent data (last 90 days).
*   **Cold Tier (Azure Blob Storage - Cool Tier):** Archives data older than 90 days at a lower cost.
*   **Intelligent Read API:** An API that checks the hot tier first, then the cold tier.
*   **Automated Archiving:** A daily timer-triggered function that migrates the data.

## Repository Structure

*   `/api`: Contains the HTTP-triggered Azure Functions for reading/writing records.
*   `/functions`: Contains the timer-triggered Azure Function for the archival process.
*   `/docs`: Contains detailed documentation, the architecture diagram and the prompts.md