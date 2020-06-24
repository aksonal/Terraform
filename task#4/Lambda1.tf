

# resource "aws_iam_role_policy" "lambda_policy" {
#   name = "lambda_policy"
#   role = "${aws_iam_role.lambda_role.id}"

#   policy = "${file("lambda_policy.json")}"
# }

resource "aws_iam_role" "lambdaRole" {
  name = "lambdaRole"

  assume_role_policy = <<EOF
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
EOF
}

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

resource "aws_iam_role_policy_attachment" "attach-policies" {
  role       = "${aws_iam_role.lambdaRole.name}"
  policy_arn = "${aws_iam_policy.policy.arn}"
}

# resource "aws_iam_role" "lambda_role" {
#   name = "lambda_role"

#   assume_role_policy = "${file("lambda-assume-policy.json")}"
# }


 locals{
   lambda_zip_location = "outputs/code.zip"

 }
 data "archive_file" "code" {
   type        = "zip"
   source_file = "code.py"
   output_path = "${local.lambda_zip_location }"
 }

 resource "aws_lambda_function" "test_lambda" {
   filename      = "${local.lambda_zip_location }"
   function_name = "Demo"
   role          = "${aws_iam_role.lambdaRole.arn}"
   handler       = "code.lambda_handler"

 
#   #source_code_hash = "${filebase64sha256("lambda_function_payload.zip")}"

   runtime = "python3.7"

 }


