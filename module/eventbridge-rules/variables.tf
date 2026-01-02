variable "eventbrige_rule" {
  description = "config details to create eventbridge rules"
  type = map(object({
    name = string
    rule_desc = string
    rule_trigger_time = string
  }))
}

variable "eventbridge_targets" {
  type = map(object({
    eventbridge_rule   = string
    lambda_arns = string
  }))
}
