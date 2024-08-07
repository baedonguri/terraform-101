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
