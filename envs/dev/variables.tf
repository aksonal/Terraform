#S3 buckers variable
variable "buckets" {
  description = "Map of S3 bucket configurations"
  type = map(object({
    s3_bucket_name = string
    bucket_tags    = map(string)
  }))
}

#lambda functions variable
variable "lambdas" {
  description = "Lambda functions config details"
  type = map(object({
    lambda_func_name = string
    lambda_role = string
    lambda_handler = string
    lambda_runtime = string
    env_vars = optional(map(string),{})
    lambda_tags = optional(map(string),{})
    lambda_memory_size = optional(number)
    lambda_timeout = optional(number)
    lambda_ephemeral_storage = number

    lambda_log_groups = object({
      log_grp_retention_period = number
      cw_log_grp_tags = optional(map(string),{})
      })

    lambda_vpc_config = optional(object({
        subnet_ids_list = list(string)
        sg_ids_list = list(string)
    }))

    lambda_triggers = optional(object({
        stmt_id = string
        trigger_source_arn = string
    }),null)
  }))
}

#stage
variable "stage" {
  description = "which env is it dev, qa or prod"
}

#rules
variable "event_rules" {
  description = "config details to create eventbridge rules"
  type = map(object({
    name = string
    rule_desc = string
    rule_trigger_time = string
  }))
}

#lambda targets
variable "lambda_targets" {
  type = map(object({
    rule_key   = string
    lambda_key = string
  }))
}
