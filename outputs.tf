data "aws_region" "current" {}

locals {
  bucket_val         = "${format("bucket = \"%s\"", aws_s3_bucket.terraform_state.id)}"
  region_val         = "${format("region = \"%s\"", data.aws_region.current.name)}"
  dynamodb_table_val = "${format("dynamodb_table = \"%s\"", aws_dynamodb_table.dynamodb_terraform_state_lock.id)}"
  key_val            = "key = \"example/path/to/state\""
  values             = "${format("      %s\n      %s\n      %s\n      %s\n", local.bucket_val, local.region_val, local.dynamodb_table_val, local.key_val)}"
}

output "state_s3_bucket_name" {
  value = "${aws_s3_bucket.terraform_state.arn}"
}

output "state_s3_bucket_arn" {
  value = "${aws_s3_bucket.terraform_state.arn}"
}

output "sample_usage" {
  description = "this shows an example of how to use the created resources for a terraform backend"
  value       = "${format("\n\n\nterraform {\n  backend \"s3\" {\n%s  }\n}", local.values)}"
}
