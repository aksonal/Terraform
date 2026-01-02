output "lambda_arns" {
    value = {
        for key,val in aws_lambda_function.lambda_functions :
            key => val.arn
    }
}
