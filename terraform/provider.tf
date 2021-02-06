terraform {
  required_providers {
    aws = {
      version = ">= 3.27.0"
      source  = "hashicorp/aws"
    }
    template = {
      version = ">= 2.2.0"
      source  = "hashicorp/archive"
    }
    archive = {
      version = ">= 2.0.0"
      source  = "hashicorp/archive"
    }
  }
}


provider "aws" {
  profile = var.aws_profile
  region  = var.aws_region
}
