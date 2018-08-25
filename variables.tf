variable "bucket_prefix" {
  description = "a descriptive prefix to use in terraform AWS locking backend resource creation"
  type        = "string"
}

variable "tags" {
  description = "tags to attach to the created resources"
  default     = {}
}
