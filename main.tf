# Create a key to encrypt at rest
resource "aws_kms_key" "state_key" {
  description = "This key is used to encrypt terraform state bucket objects"

  # default value
  deletion_window_in_days = 30

  # let's try key rotation
  enable_key_rotation = true
}

# Create an S3 bucket so that we can store our state in
# there
resource "aws_s3_bucket" "terraform_state" {
  bucket = "${format("%s-terraform", var.bucket_prefix)}"

  acl = "private"

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = "${aws_kms_key.state_key.arn}"
        sse_algorithm     = "aws:kms"
      }
    }
  }

  lifecycle {
    prevent_destroy = true
  }

  tags = "${var.tags}"
}

# We also need a DynamoDB table for locking
resource "aws_dynamodb_table" "dynamodb_terraform_state_lock" {
  name = "${format("%s-state-file-lock", var.bucket_prefix)}"

  # This is required per the Terraform documentation
  # https://www.terraform.io/docs/backends/types/s3.html#dynamodb_table
  hash_key = "LockID"

  read_capacity  = 20
  write_capacity = 20

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = "${var.tags}"
}
