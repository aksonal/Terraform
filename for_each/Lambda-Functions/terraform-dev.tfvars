stage = "dev"
lambda_functions_config = {
    lambda-1 = {
        lambda_func_name = "test-lambda-1-tf"
        lambda_role = "arn:aws:iam::123456789012:role/lambda-vpc-access-role"
        lambda_handler = "index.handler"
        lambda_runtime = "python3.12"
        lambda_memory_size = 256
        lambda_timeout = 30 #sec
        lambda_ephemeral_storage = 600
        env_vars = {
            ENVIRONMENT = "qa"
            LOG_LEVEL   = "info"
        }
        lambda_tags = {
            Environment = "Terraform"
            Application = "rbac-qa"
        }
        lambda_log_groups = {
            log_grp_retention_period = 14
                cw_log_grp_tags = {
                    Lambda = "Rbac"
                    Owner = "Terraform"
                }
        }
        lambda_vpc_config = {
            subnet_ids_list = ["subnet-0f1ecdserf345r56t","subnet-06bffdrf345rf4d5t"]
            sg_ids_list = ["sg-0dfe50a63de1c5c07"]
        }
    },
    lambda-2 = {
        lambda_func_name = "test-lambda-2-tf"
        lambda_role = "arn:aws:iam::123456789012:role/lambda-basic-execution-role"
        lambda_handler = "app.handler"
        lambda_runtime = "python3.13"
        lambda_ephemeral_storage = 512
        env_vars = {
            ENVIRONMENT = "dev"
            LOG_LEVEL   = "error"
        }
        lambda_log_groups = {
            log_grp_retention_period = 14
            }
        lambda_triggers = {
            stmt_id = "InvokeLambdaUsingEventBridgeRule"
            trigger_source_arn = "5-min-rule"
        }
    }
}

eventbrige_rule = {
    "5-min-rule" = {
        name = "trigger-lambda-every-5-mins"
        rule_desc = "triggers lambda every 5 mins"
        rule_trigger_time = "rate(5 minutes)"
    },
    "10-min-rule" = {
        name = "trigger-lambda-every-10-mins"
        rule_desc = "triggers lambda every 10 mins"
        rule_trigger_time = "rate(10 minutes)"
    }
}
