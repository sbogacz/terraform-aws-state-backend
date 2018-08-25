# terraform-aws-state-backend

This is a simple terraform module to bootstrap the creation of necessary resources to have a shared AWS-based S3 backend. 

It creates few resources, but opinions come included
* A KMS key with rotation enabled
* An S3 bucket with SSE (using the above key), versioning, and private ACLs.
* A DynamoDB table to be used to lock the state file and avoid multiple concurrent deploys


