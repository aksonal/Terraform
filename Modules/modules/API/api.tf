resource "aws_api_gateway_rest_api" "example" {
  name = var.api_gateway_name
}

resource "aws_api_gateway_resource" "example" {
  parent_id   = aws_api_gateway_rest_api.example.root_resource_id
  path_part   = var.method_1
  rest_api_id = aws_api_gateway_rest_api.example.id
}

resource "aws_api_gateway_method" "example" {
  authorization = "NONE"
  http_method   = "POST"
  resource_id   = aws_api_gateway_resource.example.id
  rest_api_id   = aws_api_gateway_rest_api.example.id
}

resource "aws_api_gateway_integration" "example" {
  http_method = aws_api_gateway_method.example.http_method
  resource_id = aws_api_gateway_resource.example.id
  rest_api_id = aws_api_gateway_rest_api.example.id
  integration_http_method = "POST"
  type        = "AWS_PROXY"
  uri         = var.lambda_arn_for_api
}

resource "aws_api_gateway_deployment" "example" {
  rest_api_id = aws_api_gateway_rest_api.example.id
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "example" {
  deployment_id = aws_api_gateway_deployment.example.id
  rest_api_id   = aws_api_gateway_rest_api.example.id
  stage_name    = var.api_stage
}