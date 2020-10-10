resource "aws_api_gateway_resource" "apig_resource" {
   rest_api_id = var.apig_id
   parent_id   = var.apig_root_id
   path_part   = "analysis"
}

resource "aws_api_gateway_method" "apig_resource" {
   rest_api_id = var.apig_id
   resource_id   = aws_api_gateway_resource.apig_resource.id
   http_method   = "POST"
   authorization = "NONE"
}

resource "aws_api_gateway_integration" "apig_resource" {
   rest_api_id = var.apig_id
   resource_id = aws_api_gateway_method.apig_resource.resource_id
   http_method = aws_api_gateway_method.apig_resource.http_method

   integration_http_method = "POST"
   type                    = "AWS"
   uri                     = var.lambda_arn
}

resource "aws_api_gateway_method_response" "apig_resource" {
    rest_api_id = var.apig_id
    resource_id = aws_api_gateway_method.apig_resource.resource_id
    http_method = aws_api_gateway_method.apig_resource.http_method
    status_code = "200"
    response_parameters = { 
        "method.response.header.Access-Control-Allow-Origin" = true 
    }
}

resource "aws_api_gateway_integration_response" "apig_resource" {
    rest_api_id = var.apig_id
    resource_id = aws_api_gateway_method.apig_resource.resource_id
    http_method = aws_api_gateway_method.apig_resource.http_method
    status_code = aws_api_gateway_method_response.apig_resource.status_code
    response_parameters = { 
        "method.response.header.Access-Control-Allow-Origin" = "'*'" 
    }
}

resource "aws_lambda_permission" "apig_resource" {
   statement_id  = "AllowAPIGatewayInvoke"
   action        = "lambda:InvokeFunction"
   function_name = var.lambda_function_name
   principal     = "apigateway.amazonaws.com"
   source_arn = "${var.apig_execution_arn}/*/*"
}