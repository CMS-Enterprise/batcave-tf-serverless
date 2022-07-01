terraform {
  required_providers {
    aws = {
      version = "~> 4.15"
    }
  }
}

module "lambda" {
  count   = var.enabled ? 1 : 0
  source  = "terraform-aws-modules/lambda/aws"
  version = "~> 3.1"

  depends_on = [
    aws_security_group.lambda
  ]

  function_name = var.service_name
  handler       = var.lambda_handler
  runtime       = var.lambda_runtime

  recreate_missing_package = true
  source_path              = "${path.module}/${var.lambda_path}"

  vpc_subnet_ids         = var.private_subnets
  vpc_security_group_ids = [aws_security_group.lambda[0].id]
  attach_network_policy  = true

  role_path                 = var.iam_role_path
  policy_path               = var.iam_role_path
  role_permissions_boundary = var.iam_role_permissions_boundary
  timeout                   = var.lambda_timeout

  environment_variables = var.lambda_environment
}

moved {
  from = module.lambda
  to   = module.lambda[0]
}

# These resources attach the ALB to the Lambda
resource "aws_lambda_permission" "alb_to_lambda" {
  count         = var.enabled ? 1 : 0
  statement_id  = "AllowExecutionFromPublicALB"
  action        = "lambda:InvokeFunction"
  principal     = "elasticloadbalancing.amazonaws.com"
  function_name = module.lambda[0].lambda_function_arn
  source_arn    = module.alb[0].target_group_arns[0]
}

resource "aws_lb_target_group_attachment" "alb_to_lambda" {
  count            = var.enabled ? 1 : 0
  target_group_arn = module.alb[0].target_group_arns[0]
  target_id        = module.lambda[0].lambda_function_arn
  depends_on       = [aws_lambda_permission.alb_to_lambda]
}
