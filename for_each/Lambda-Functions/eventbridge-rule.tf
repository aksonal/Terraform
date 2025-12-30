#eventbridge rules

resource "aws_cloudwatch_event_rule" "eventbrodge_rules" {
    for_each = var.eventbrige_rule
    name        = each.value.name
    description = each.value.rule_desc
    schedule_expression = each.value.rule_trigger_time
}
