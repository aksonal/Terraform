output "lambdaArn" {
  value = aws_lambda_function.test_lambda.invoke_arn #invoke_arn - ARN to be used for invoking Lambda Function from API Gateway - to be used in aws_api_gateway_integration's uri.
}