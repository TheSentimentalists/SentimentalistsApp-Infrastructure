resource "aws_api_gateway_rest_api" "apig" {
  name        = "app-${var.apig_name}"
  description = var.apig_name
}

