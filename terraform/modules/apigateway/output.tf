output "apig_id" {
  value = aws_api_gateway_rest_api.apig.id
}

output "apig_root_id" {
  value = aws_api_gateway_rest_api.apig.root_resource_id
}

output "apig_execution_arn" {
  value = aws_api_gateway_rest_api.apig.execution_arn
}