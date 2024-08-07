# 테라폼 버전 및 AWS 프로바이더 설정
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# AWS 프로바이더 설정
provider "aws" {
  region = var.region
}

# VPC 모듈 호출
module "vpc" {
  source = "../../modules/vpc"  # VPC 모듈 경로

  region   = var.region
  vpc_cidr = var.vpc_cidr
  vpc_name = var.vpc_name
}

# 출력 정의
output "vpc_id" {
  description = "ID of the created VPC"
  value       = module.vpc.vpc_id
}

output "subnet_1_id" {
  description = "ID of the first subnet"
  value       = module.vpc.subnet_1_id
}

output "subnet_2_id" {
  description = "ID of the second subnet"
  value       = module.vpc.subnet_2_id
}

output "internet_gateway_id" {
  description = "ID of the created Internet Gateway"
  value       = module.vpc.internet_gateway_id
}

output "private_subnet_1_id" {
  description = "ID of the first private subnet"
  value       = module.vpc.private_subnet_1_id
}

output "private_subnet_2_id" {
  description = "ID of the second private subnet"
  value       = module.vpc.private_subnet_2_id
}

output "nat_gateway_id" {
  description = "ID of the NAT Gateway"
  value       = module.vpc.nat_gateway_id
}
