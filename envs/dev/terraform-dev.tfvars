buckets = {
    bucket-1 = {
        s3_bucket_name = "test-bucket-1-dd45"
        bucket_tags = {
            Name = "Demo Bucket"
            Owner = "Terraform"
        }
    },
    bucket-2 = {
        s3_bucket_name = "test-bucket-2-sder"
        bucket_tags = {
            Name = "Demo-Bucket-3"
            Owner = "TF"
        }
    }
}

lambdas = {
  lambda-1 = {
    lambda_func_name = "test-lambda-1-tf-sonal"
        lambda_role = "arn:aws:iam::949714097782:role/databricks-cdp-api-prod-us-east-2-lambdaRole"
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
            subnet_ids_list = ["subnet-0cd063a32edd112a1"]
            sg_ids_list = ["sg-0dfe50a63de1c5c07"]
        }
  },
  lambda-2 = {
        lambda_func_name = "test-lambda-2-tf-sonal"
        lambda_role = "arn:aws:iam::949714097782:role/databricks-cdp-api-prod-us-east-2-lambdaRole"
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

stage = "dev"

event_rules = {
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

lambda_targets = {
    target-1 = {
        rule_key = "5-min-rule"
        lambda_key = "lambda-2"
    }
}
