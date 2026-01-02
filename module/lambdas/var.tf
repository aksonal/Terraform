variable "lambda_functions_config" {
  description = "Lambda function configurations"
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

    validation {
      condition = alltrue([
        for _,runtime in var.lambda_functions_config :
        contains(["python3.12","python3.13"],runtime.lambda_runtime)
      ])
      error_message = "Unsupported Lambda runtime"
    }
}

variable "env_stage" {
  description = "stage is it edev, qa or prod"
  type = string
}

variable "eventbridge_rule_arns" {
  description = "map of lambda name key and eventbridge arn as value"
  type = map(string)
}
