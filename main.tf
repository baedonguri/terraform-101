terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = var.region
}

module "vpc" {
  source = "./modules/vpc"
  vpc_name = var.vpc_name
  vpc_cidr = var.vpc_cidr
  region = var.region
}

module "s3" {
    source      = "./modules/s3"
    bucket_name = var.bucket_name
    bucket_tags = var.bucket_tags
    bucket_enable_versioning = var.bucket_enable_versioning
}