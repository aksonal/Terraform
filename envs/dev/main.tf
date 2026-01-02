module "s3_buckets" {
  source="../../module/s3"

  bucket_configs = var.buckets
}

module "lambda_functions" {
  source="../../module/lambdas"
  lambda_functions_config = var.lambdas
  eventbridge_rule_arns = local.lambda_eventbridge_arns
  env_stage = var.stage
}

module "eventbridge_rules" {
  source = "../../module/eventbridge-rules"
  eventbrige_rule = var.event_rules
  eventbridge_targets = local.eventbridge_lambda_arns
}
