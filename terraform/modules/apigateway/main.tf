resource "aws_api_gateway_rest_api" "apig" {
  name        = "app-${var.apig_name}-${var.apig_stage}"
  description = "${var.apig_name}-${var.apig_stage}"
}

