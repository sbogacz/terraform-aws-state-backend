# terraform-aws-state-backend

This is a simple terraform module to bootstrap the creation of necessary resources to have a shared AWS-based S3 backend. 

It creates few resources, but opinions come included
* A KMS key with rotation enabled
* An S3 bucket with SSE (using the above key), versioning, and private ACLs.
* A DynamoDB table to be used to lock the state file and avoid multiple concurrent deploys

## Example Usage
```hcl
provider "aws" {
  region = "us-east-2"
}

module "aws_backend_resources" {
  source        = "git::github.com/sbogacz/terraform-aws-state-backend"
  bucket_prefix = "my-prefix"

  tags = {
    Type        = "Infrastructure"
    Description = "Resources to manage TF State"
  }
}

output "sample_usage" {
  value = "${module.aws_backend_resources.sample_usage}"
}
```

## Sample Usage
The last line in the example is simply to produce a starter that you can use in the subsequent Terraform projects that will leverage this common backend.

If you follow the pattern above to use this module, you could also print the output with `terraform output sample_usage`
which would yield something like:

```
terraform {
  backend "s3" {
      bucket = "my-prefix-terraform"
      region = "us-east-2"
      dynamodb_table = "my-prefix-state-file-lock"
      key = "example/path/to/state"
  }
}
```

Which you could copy and paste into some other Terraform `main.tf`
