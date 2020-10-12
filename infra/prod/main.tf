terraform {
  backend "s3" {
    bucket  = "sentimentalists-terraform"
    key     = "shared-prod"
    region  = "eu-west-2"
  }
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region  = "eu-west-2"
}

module "backend-apig" {
  source               = "github.com/TheSentimentalists/SentimentalistsApp-Infrastructure/terraform/modules/apigateway"
  apig_name            = "sentimentalists-prod"
}