variable "bucket_name" {
  description = "The name of the S3 Bucket"
  type        = string
}

variable "bucket_tags" {
  description = "Tags"
  type        = map(string)
  default     = {}
}

variable "bucket_enable_versioning" {
  description = "Enable versioning on the bucket"
  type        = bool
  default     = false
}
