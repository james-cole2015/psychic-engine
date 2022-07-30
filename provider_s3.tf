terraform {
  backend "s3" {
    bucket         = "averyclark-tf-bucket"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "s3backend-tf"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }


}

provider "aws" {
  region                   = var.region
  shared_credentials_files = ["~/.aws/credentials"]
  shared_config_files      = ["~/.aws/config"]
}