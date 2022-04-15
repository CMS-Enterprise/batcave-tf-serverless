resource "aws_ssm_parameter" "vpc_id" {
  type  = "String"
  name  = "/${local.resource_prefix}/vpc_id"
  value = local.vpc_id
}

resource "aws_ssm_parameter" "public_subnet_ids" {
  type  = "StringList"
  name  = "/${local.resource_prefix}/public_subnet_ids"
  value = join(",", local.subnets)
}

