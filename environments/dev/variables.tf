# AWS 리전 설정
variable "region" {
  description = "AWS region"
  type        = string
}

# VPC CIDR 블록 설정
variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
}

# VPC 이름 설정
variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
}

# S3 버킷 이름 설정
variable "bucket_name" {
  description = "The name of the S3 Bucket"
  type        = string
}

# S3 버킷 태그 설정
variable "bucket_tags" {
  description = "Tags"
  type        = map(string)
}

# S3 버저닝 정책 허용 여부
variable "bucket_enable_versioning" {
  description = "Enable versioning on the bucket"
  type        = bool
}
