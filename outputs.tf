data "aws_region" "current" {}

locals {
  values = {
    bucket         = "${aws_s3_bucket.terraform_state.arn}"
    region         = "${data.aws_region.current.name}"
    dynamodb_table = "${aws_dynamodb_table.dynamodb_terraform_state_lock.id}"
    key            = "example/path/to/state"
  }

  #tf_backend_sample = "${format("terraform {\n\t backend \\\"s3\\\" {\n %s}\n}\n", jsonencode(values))}"
  tf_backend_sample = "${format("terraform {\n  backend \"s3\" {\n %s}\n}\n", jsonencode(values))}"
}

output "state_s3_bucket_name" {
  value = "${aws_s3_bucket.terraform_state.arn}"
}

output "state_s3_bucket_arn" {
  value = "${aws_s3_bucket.terraform_state.arn}"
}
