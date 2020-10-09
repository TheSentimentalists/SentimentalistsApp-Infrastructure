terraform {
  backend "s3" {
    bucket  = "sentimentalists-terraform"
    key     = "testtest-terraform"
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

module "backend-lambda" {
  source         = "github.com/TheSentimentalists/SentimentalistsApp-Infrastructure/terraform/modules/lambda"
  lambda_stage   = "prod"
  lambda_name    = "sentimentalistsapp-testtest-backend"
  lambda_payload = "../src/payload.zip"
}

module "backend-apig" {
  source               = "github.com/TheSentimentalists/SentimentalistsApp-Infrastructure/terraform/modules/apigateway"
  apig_stage           = "prod"
  apig_name            = "sentimentalistsapp-testtest-backend"
  lambda_arn           = module.backend-lambda.apig_invoke_arn
  lambda_function_name = module.backend-lambda.apig_function_name
}
