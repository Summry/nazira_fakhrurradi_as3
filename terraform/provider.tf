# Specifies the required providers and their versions.
# The AWS provider version 4.16 or later and the Local provider version 2.1 or later are required.

terraform {
  backend "s3" {
    bucket = "naz-fakh-terraform-state-backend"
    key    = "terraform.tfstate"
    region = var.region
    encrypt = true
    dynamodb_table = "naz-fakh-terraform-state-lock"
  }
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 5.0.0"
    }
  }
}

# Configure the AWS provider
provider "aws" {
  region = var.region
}