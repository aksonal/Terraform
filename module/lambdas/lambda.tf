# Lambda function
resource "aws_lambda_function" "lambda_functions" {
    for_each = var.lambda_functions_config
    filename      = data.archive_file.lambda_zip.output_path
    function_name = "${each.value.lambda_func_name}-${var.env_stage}"
    role          = each.value.lambda_role 
    handler       = "${each.value.lambda_handler}"
    memory_size = each.value.lambda_memory_size
    timeout     = each.value.lambda_timeout

    runtime = each.value.lambda_runtime

    environment {
        variables = each.value.env_vars
    }

    tags = each.value.lambda_tags

    dynamic "vpc_config" {
        for_each = each.value.lambda_vpc_config != null ? [each.value.lambda_vpc_config] : []
        
        content {
        subnet_ids         = vpc_config.value.subnet_ids_list
        security_group_ids = vpc_config.value.sg_ids_list
        }
    }

    # /tmp storage
    ephemeral_storage {
      size = each.value.lambda_ephemeral_storage
    }

    lifecycle { 
        ignore_changes = [ 
            filename, 
            source_code_hash, 
            environment 
            ] 
    }
}

#lambda-log-groups
resource "aws_cloudwatch_log_group" "lambda_log_grps" {
    for_each = var.lambda_functions_config
    name              = "/aws/lambda/${aws_lambda_function.lambda_functions[each.key].function_name}"
    retention_in_days = each.value.lambda_log_groups.log_grp_retention_period

    tags = each.value.lambda_log_groups.cw_log_grp_tags
}

# lambda triggers
resource "aws_lambda_permission" "lambda_triggers" {
    for_each = {
        for key,value in var.lambda_functions_config :
          key => value.lambda_triggers
          if value.lambda_triggers != null
    }
    statement_id  = each.value.stmt_id
    action        = "lambda:InvokeFunction"
    function_name = aws_lambda_function.lambda_functions[each.key].function_name
    principal     = "events.amazonaws.com"
    source_arn    = var.eventbridge_rule_arns[each.key]
}
