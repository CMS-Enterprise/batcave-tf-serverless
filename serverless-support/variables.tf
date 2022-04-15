variable "resource_prefix" {
  type        = string
  description = "A name that will be prefixed on all resources.  Something like 'test-myapp', 'dev-thing'"
}

variable "vpc_id" {
  type    = string
  default = ""
}

variable "subnet_ids" {
  type        = list(any)
  default     = []
  description = "List of subnet ids; defaults to default vpc subnets"
}

variable "lambda_additional_policy_document_json" {
  type        = string
  default     = ""
  description = "JSON to add to the lambda role created for this resource; default to no additioanl permissions"
}

variable "export_to_parameter_store" {
  type        = bool
  default     = true
  description = "Export key values to parameterstore for easy ingestion by serverless framework?"
}

variable "iam_role_path" {
  default = "/delegatedadmin/developer/"
}

variable "iam_role_permissions_boundary" {
}

variable "security_group_inbound_cidr" {
  default = "10.0.0.0/8"
}

variable "environment" {}

variable "create_custom_domain" {
  type    = bool
  default = false
}

variable "custom_subdomain" {
  type    = string
  default = "status"
}

variable "base_domain" {
  default = ""
}
