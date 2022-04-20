# This NLB is the front-end of the service.
# It lives in the transport subnet to be accessible by
# services outside of CMSCloud

data "aws_acm_certificate" "acm_certificate" {
  count       = var.create_custom_domain ? 1 : 0
  domain      = var.base_domain
  types       = ["AMAZON_ISSUED"]
  most_recent = true
}

module "nlb" {
  depends_on = [
    module.alb
  ]
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 6.0"

  name = "${var.service_name}-nlb"

  load_balancer_type = "network"
  internal           = true

  vpc_id = var.vpc_id
  #subnets = var.private_subnets
  subnet_mapping = [for k, v in var.transport_subnet_cidr_blocks : { subnet_id = k, private_ipv4_address = cidrhost(v, var.transport_subnet_ip_index) }]

  #access_logs = {
  #  bucket = "my-nlb-logs"
  #}

  target_groups = [
    {
      #name_prefix      = "${var.service_name}-80-"
      backend_protocol = "TCP"
      backend_port     = 80
      target_type      = "alb"
      vpc_id           = var.vpc_id
      targets = [
        {
          target_id = module.alb.lb_arn
        },
      ]
    },
    {
      #name_prefix      = "${var.service_name}-443-"
      backend_protocol = "TCP"
      backend_port     = 443
      target_type      = "alb"
      vpc_id           = var.vpc_id
      targets = [
        {
          target_id = module.alb.lb_arn
        },
      ]
    },
  ]

  #https_listeners = [
  #]

  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "TCP"
      target_group_index = 0
    },
    {
      port     = 443
      protocol = "TCP"
      #certificate_arn    = var.create_custom_domain ? data.aws_acm_certificate.acm_certificate[0].arn : null
      target_group_index = 1
    }
  ]

  #tags = {
  #  Environment = "Test"
  #}
}
