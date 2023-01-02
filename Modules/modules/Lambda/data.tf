data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "modules/Lambda/lambda_data/lambda.py"
  output_path = "modules/Lambda/lambda_data/lambda.zip"
}