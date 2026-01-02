output "eventbridge_rules_arns" {
  description = "map of enventbridge rule arns"
  value = {
    for rule,value in aws_cloudwatch_event_rule.eventbrodge_rules :
        rule => value.arn
  }
}
