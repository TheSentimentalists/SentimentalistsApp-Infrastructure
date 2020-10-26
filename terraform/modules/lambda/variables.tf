# Stage
variable "lambda_stage" {
  type = string
}

# Lambda Name
variable "lambda_name" {
  type = string
}

# Lambda Handler
variable "lambda_handler" {
  type    = string
  default = "lambda_function.lambda_handler"
}

# S3 Bucket and Key
variable "s3_bucket" {
  type    = string
}

variable "s3_key" {
  type    = string
}