# batcave-tf-serverless

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_alb"></a> [alb](#module\_alb) | terraform-aws-modules/alb/aws | ~> 6.0 |
| <a name="module_lambda"></a> [lambda](#module\_lambda) | terraform-aws-modules/lambda/aws | ~> 3.1 |

## Resources

| Name | Type |
|------|------|
| [aws_lambda_permission.alb_to_lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission) | resource |
| [aws_lb_target_group_attachment.alb_to_lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group_attachment) | resource |
| [aws_route53_record.dns](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_security_group.lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.https-ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ingress_cidrs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ingress_prefix_list](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_acm_certificate.acm_certificate](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/acm_certificate) | data source |
| [aws_route53_zone.dns](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alb_access_logs"></a> [alb\_access\_logs](#input\_alb\_access\_logs) | Map of aws\_lb access\_log config | `map` | `{}` | no |
| <a name="input_base_domain"></a> [base\_domain](#input\_base\_domain) | The base domain of the services the lambda should be requesting to.  eg: 'batcave.internal.cms.gov' | `string` | n/a | yes |
| <a name="input_create_custom_domain"></a> [create\_custom\_domain](#input\_create\_custom\_domain) | Optionally create a custom domain for this serverless service | `bool` | `false` | no |
| <a name="input_custom_subdomain"></a> [custom\_subdomain](#input\_custom\_subdomain) | Subdomain for the optionally created dns records | `string` | `"status"` | no |
| <a name="input_frontend_subnets"></a> [frontend\_subnets](#input\_frontend\_subnets) | List of subnet ids to house the front-end of this lambda (such as Shared subnet or Transport subnet) | `list(any)` | n/a | yes |
| <a name="input_iam_role_path"></a> [iam\_role\_path](#input\_iam\_role\_path) | n/a | `string` | `"/delegatedadmin/developer/"` | no |
| <a name="input_iam_role_permissions_boundary"></a> [iam\_role\_permissions\_boundary](#input\_iam\_role\_permissions\_boundary) | n/a | `string` | `""` | no |
| <a name="input_ingress_cidrs"></a> [ingress\_cidrs](#input\_ingress\_cidrs) | List of CIDR Blocks to attach to ALB Security Group | `list(any)` | <pre>[<br>  "10.0.0.0/8"<br>]</pre> | no |
| <a name="input_ingress_prefix_lists"></a> [ingress\_prefix\_lists](#input\_ingress\_prefix\_lists) | List of prefix lists to attach to ALB Security Group | `list(any)` | `[]` | no |
| <a name="input_ingress_sgs"></a> [ingress\_sgs](#input\_ingress\_sgs) | A list of security groups in which https ingress rules will be created | `list(string)` | `[]` | no |
| <a name="input_lambda_environment"></a> [lambda\_environment](#input\_lambda\_environment) | Environment variables used by the lambda function. | `map(string)` | `null` | no |
| <a name="input_lambda_handler"></a> [lambda\_handler](#input\_lambda\_handler) | The entry point of the lambda (i.e. the fully qualified name of the function to be invoked: file-or-module-name.function-name) | `string` | n/a | yes |
| <a name="input_lambda_path"></a> [lambda\_path](#input\_lambda\_path) | Path to the lambda code | `string` | `"lambda"` | no |
| <a name="input_lambda_runtime"></a> [lambda\_runtime](#input\_lambda\_runtime) | The runtime environment to use for this lambda (e.g. 'python3.9' or 'nodejs16.x') | `string` | `"nodejs16.x"` | no |
| <a name="input_lambda_timeout"></a> [lambda\_timeout](#input\_lambda\_timeout) | The number of seconds the lambda will be allowed to execute before timing out | `number` | `3` | no |
| <a name="input_private_subnets"></a> [private\_subnets](#input\_private\_subnets) | List of subnet ids where the lambda will execute | `list(any)` | n/a | yes |
| <a name="input_route53_zone_type"></a> [route53\_zone\_type](#input\_route53\_zone\_type) | Optionally create DNS records, and lookup either 'private' or 'public' r53 zone | `string` | `"private"` | no |
| <a name="input_service_name"></a> [service\_name](#input\_service\_name) | Name of the serverless service | `string` | `"batcave-status"` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | n/a | `any` | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
