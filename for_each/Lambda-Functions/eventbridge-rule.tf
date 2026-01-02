#eventbridge rules

resource "aws_cloudwatch_event_rule" "eventbrodge_rules" {
    for_each = var.eventbrige_rule
    name        = each.value.name
    description = each.value.rule_desc
    schedule_expression = each.value.rule_trigger_time
}

#eventbridge targer
resource "aws_cloudwatch_event_target" "eventbridge_rule_targets" {
    for_each = var.eventbridge_targets
    arn  = aws_lambda_function.lambda_functions[each.value.lambda_key].arn
    rule = aws_cloudwatch_event_rule.eventbrodge_rules[each.value.rule_key].name
}
