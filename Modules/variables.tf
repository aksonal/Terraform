variable "region" {}
variable "accountId" {}

variable "image_id" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "api_gateway_name" {}
variable "method_name" {}
variable "lambda_name" {}
variable "lambda_role_name" {}
variable "api_stage_name" {}
