#module "serverless" {
#  source                        = "./serverless-support/"
#  resource_prefix               = local.resource_prefix
#  vpc_id                        = local.vpc_id
#  iam_role_path                 = local.iam_role_path
#  iam_role_permissions_boundary = local.iam_role_permissions_boundary
#  environment                   = var.environment
#  base_domain                   = var.base_domain
#  create_custom_domain          = var.create_custom_domain
#  custom_subdomain              = var.custom_subdomain
#}
#
