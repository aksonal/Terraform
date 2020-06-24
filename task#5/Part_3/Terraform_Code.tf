#Code to create API and lambda function using terraform

# API Gateway
resource "aws_api_gateway_rest_api" "api" {
  name = "API2"
}

#creation of resource
resource "aws_api_gateway_resource" "resource" {
  path_part   = "Student_Record"
  parent_id   = "${aws_api_gateway_rest_api.api.root_resource_id}"
  rest_api_id = "${aws_api_gateway_rest_api.api.id}"
}

#creation of method
resource "aws_api_gateway_method" "method" {
  rest_api_id   = "${aws_api_gateway_rest_api.api.id}"
  resource_id   = "${aws_api_gateway_resource.resource.id}"
  http_method   = "GET"
  authorization = "NONE"
}

#creation of integration
resource "aws_api_gateway_integration" "integration" {
  rest_api_id             = "${aws_api_gateway_rest_api.api.id}"
  resource_id             = "${aws_api_gateway_resource.resource.id}"
  http_method             = "${aws_api_gateway_method.method.http_method}"
  integration_http_method = "POST"
  type                    = "AWS"
  uri                     = "${aws_lambda_function.lambda.invoke_arn}"

  request_templates = {                  # Not documented
    "application/json" = "${file("api_gateway_body_mapping.json")}"
  }

}

#setting method response
resource "aws_api_gateway_method_response" "response_200" {
  rest_api_id = "${aws_api_gateway_rest_api.api.id}"
  resource_id = "${aws_api_gateway_resource.resource.id}"
  http_method = "${aws_api_gateway_method.method.http_method}"
  status_code = "200"
}

#setting integration response
resource "aws_api_gateway_integration_response" "Integration_Response" {
   rest_api_id = "${aws_api_gateway_rest_api.api.id}"
   resource_id = "${aws_api_gateway_resource.resource.id}"
   http_method = "${aws_api_gateway_method.method.http_method}"
   status_code = "${aws_api_gateway_method_response.response_200.status_code}"

   depends_on = ["aws_api_gateway_integration.integration"]
  # Transforms the backend JSON response to XML
#    response_templates = {
#      "application/xml" = <<EOF
#  #set($inputRoot = $input.path('$'))
#  <?xml version="1.0" encoding="UTF-8"?>
#  <message>
#      $inputRoot.body
#  </message>
#  EOF
#    }
 }





# Lambda permission
resource "aws_lambda_permission" "apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = "mylambda"
  principal     = "apigateway.amazonaws.com"

  # More: http://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-control-access-using-iam-policies-to-invoke-api.html
  #source_arn = "arn:aws:execute-api:${var.myregion}:${var.accountId}:${aws_api_gateway_rest_api.api.id}/*/${aws_api_gateway_method.method.http_method}${aws_api_gateway_resource.resource.path}"
}

#local variable
locals{
   lambda_zip_location = "outputs/code.zip"

 }

#archive to create a .zip  file of lambda function
data "archive_file" "code" {
   type        = "zip"
   source_file = "code.py"
   output_path = "${local.lambda_zip_location }"
 }

#creating lambda function
resource "aws_lambda_function" "lambda" {
  filename      = "${local.lambda_zip_location }"
  function_name = "mylambda"
  role          = "${aws_iam_role.role.arn}"
  handler       = "code.lambda_handler"
  runtime       = "python3.7"
}

# IAM Role creation
resource "aws_iam_role" "role" {
  name = "myrole"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY
}

#Policy creation for lambda
resource "aws_iam_policy" "policy" {
  name        = "test-policy"
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "*",
            "Resource": "*"
        }
    ]
}
EOF
}

#policy created above attachment to lambda
resource "aws_iam_role_policy_attachment" "attach-policies" {
  role       = "${aws_iam_role.role.name}"
  policy_arn = "${aws_iam_policy.policy.arn}"
}
