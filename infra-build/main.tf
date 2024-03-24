terraform {
  required_version = "= 1.1.6"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "= 4.24.0"
    }
  }

  backend "s3" {
    bucket = "tfstate-backend-store"
    key    = "terraform.tfstate"
    region = "ap-southeast-2"
  }
}

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}
