terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  backend "s3" {
    bucket = "tranquyet-aws-cloud-practice-infra"
    key    = "networking/3-tier/terraform.tfstate"
    region = "ap-southeast-1"
  }

  required_version = ">= 1.2.0"
}
