locals {
    #forming eventbridge targets arn (sns, lambda , api etc)
  eventbridge_lambda_arns ={
    for k,v in var.lambda_targets :
        k => {
            eventbridge_rule = v.rule_key
            lambda_arns = module.lambda_functions.lambda_arns[v.lambda_key]
        }
  }
  lambda_eventbridge_arns = {
    for lambda_name, lambda_cfg in var.lambdas :
    lambda_name => (
      lambda_cfg.lambda_triggers != null
      ? module.eventbridge_rules.eventbridge_rules_arns[
          lambda_cfg.lambda_triggers.trigger_source_arn
        ]
      : null
    )
  }
}
