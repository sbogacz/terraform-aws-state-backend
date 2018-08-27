variable "bucket_prefix" {
  description = "a descriptive prefix to use in terraform AWS locking backend resource creation"
  type        = "string"
}

variable "lock_table_read_capacity" {
  description = "the read capacity of the configured dynamo state lock table"
  default     = 5
}

variable "lock_table_write_capacity" {
  description = "the write capacity of the configured dynamo state lock table"
  default     = 5
}

variable "tags" {
  description = "tags to attach to the created resources"
  default     = {}
}
