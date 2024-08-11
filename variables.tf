variable "region" {
  description = "AWS region"
  type        = string
  default     = "ap-northeast-2"
}

variable "vpc_cidr" {
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_name" {
  type        = string
  default     = "terraform-101"
}

variable "bucket_name" {
  type        = string
  default     = "terraform101-bucket"
}

variable "bucket_tags" {
  type        = map(string)
  default     = {
    Project   = "terraform-101"
  }
}

variable "bucket_enable_versioning" {
  type        = bool
  default     = true
}
