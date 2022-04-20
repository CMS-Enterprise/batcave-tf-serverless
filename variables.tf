variable "project" {
  default = "batcave"
}

variable "environment" {
  default = "dev"
}

variable "service_name" {
  default     = "batcave-status"
  type        = string
  description = "Name of the serverless service"
}

variable "vpc_id" {}

variable "private_subnets" {
  type = list(any)
}

variable "base_domain" {}

variable "create_custom_domain" {
  type        = bool
  default     = false
  description = "Optionally create a custom domain for this serverless service"
}
variable "iam_role_path" {
  default = "/delegatedadmin/developer/"
}

variable "iam_role_permissions_boundary" {
  default = ""
}

variable "route53_zone_type" {
  default     = "private"
  type        = string
  description = "Optionally create DNS records, and lookup either 'private' or 'public' r53 zone"
}

variable "custom_subdomain" {
  default     = "status"
  type        = string
  description = "Subdomain for the optionally created dns records"
}

variable "transport_subnet_cidr_blocks" {
  description = "Map of transport subnets to cidrs for creating the NLB"
  type = map(any)
}
variable "tg_prefix" {
  type = string
  default = "lambda"
  description = "Name prefix for target groups created; must be < 6 characters"
}
