module myLambda {
    source = "./modules/Lambda" 
    function_name = var.lambda_name
    existing_lambda_role = data.aws_iam_role.lambda_role.arn
    api_gateway_id = module.myApi.api_id
    region = var.region
    accountId = var.accountId
}

#lambda arn
output "lambda_arn" {
  value = module.myLambda.lambdaArn
}

