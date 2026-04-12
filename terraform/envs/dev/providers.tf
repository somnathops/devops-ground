terraform {
  required_version = ">=1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  backend "s3" {
    bucket = "terraform-state-bucket-157788111769"
    key    = "dev/vpc/terraform.tfstate"
    region = "us-west-2"
    encrypt = true
    use_lockfile = true
  }
}

provider "aws" {
    region = var.region
}