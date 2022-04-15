
output "apigw_id" {
  value = aws_api_gateway_rest_api.apigw.id
}
output "apigw_root_resource_id" {
  value = aws_api_gateway_rest_api.apigw.root_resource_id
}
output "security_group_id" {
  value = aws_security_group.lambda.id
}
output "lambda_role_arn" {
  value = aws_iam_role.lambda.arn
}
output "lambda_role_id" {
  value = aws_iam_role.lambda.id
}
output "custom_domain_target" {
  value = try(aws_api_gateway_domain_name.apigw[0].cloudfront_domain_name, "")
}
