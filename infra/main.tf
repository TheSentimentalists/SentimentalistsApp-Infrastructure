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
  apig_name            = "sentimentalistsapp-testtest-backend"
}

module "backend-apig-lambdaresource" {
  source               = "github.com/TheSentimentalists/SentimentalistsApp-Infrastructure/terraform/modules/apigateway_resource"
  apig_id              = module.backend-apig.apig_id
  apig_root_id         = module.backend-apig.apig_root_id
  apig_execution_arn   = module.backend-apig.apig_execution_arn
  lambda_arn           = module.backend-lambda.apig_invoke_arn
  lambda_function_name = module.backend-lambda.apig_function_name
}

module "backend-apig-deployment" {
  source               = "github.com/TheSentimentalists/SentimentalistsApp-Infrastructure/terraform/modules/apigateway_deploy"
  apig_id              = module.backend-apig.apig_id
  apig_stage           = "prod"
}
