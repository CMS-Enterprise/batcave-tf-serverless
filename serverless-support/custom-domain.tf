resource "aws_api_gateway_domain_name" "apigw" {
  count           = var.create_custom_domain ? 1 : 0
  certificate_arn = data.aws_acm_certificate.acm_certificate[0].arn
  domain_name     = "${var.custom_subdomain}.${var.base_domain}"
}

resource "aws_api_gateway_base_path_mapping" "apigw" {
  count       = var.create_custom_domain ? 1 : 0
  #depends_on = [
  #  aws_api_gateway_integration.initial_integration[0]
  #  aws_api_gateway_integration.initial_integration[0]
  #]
  api_id      = aws_api_gateway_rest_api.apigw.id
  stage_name  = aws_api_gateway_stage.initial_stage[0].stage_name
  domain_name = aws_api_gateway_domain_name.apigw[0].domain_name
}

data "aws_acm_certificate" "acm_certificate" {
  count       = var.create_custom_domain ? 1 : 0
  domain      = var.base_domain
  types       = ["AMAZON_ISSUED"]
  most_recent = true
}

resource "aws_api_gateway_deployment" "initial_deployment" {
  count = var.create_custom_domain ? 1 : 0
  depends_on = [
    aws_api_gateway_method.initial_method[0],
    aws_api_gateway_integration.initial_integration[0],
  ]

  rest_api_id = aws_api_gateway_rest_api.apigw.id
  description = "Deployment - default configuration by terraform"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "initial_stage" {
  count         = var.create_custom_domain ? 1 : 0
  deployment_id = aws_api_gateway_deployment.initial_deployment[0].id
  rest_api_id   = aws_api_gateway_rest_api.apigw.id
  stage_name    = var.environment
  description   = "default deployment"
}

resource "aws_api_gateway_resource" "initial_resource" {
  count         = var.create_custom_domain ? 1 : 0
  rest_api_id = aws_api_gateway_rest_api.apigw.id
  parent_id   = aws_api_gateway_rest_api.apigw.root_resource_id
  path_part   = "initial_method"
}
resource "aws_api_gateway_method" "initial_method" {
  count         = var.create_custom_domain ? 1 : 0
  rest_api_id   = aws_api_gateway_rest_api.apigw.id
  resource_id   = aws_api_gateway_resource.initial_resource[0].id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "initial_integration" {
  count         = var.create_custom_domain ? 1 : 0
  rest_api_id          = aws_api_gateway_rest_api.apigw.id
  resource_id          = aws_api_gateway_resource.initial_resource[0].id
  http_method          = aws_api_gateway_method.initial_method[0].http_method
  type                 = "MOCK"

  # Transforms the incoming XML request to JSON
  request_templates = {
    "application/xml" = <<EOF
{
   "body" : $input.json('$')
}
EOF
  }
}
