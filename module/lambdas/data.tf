data "archive_file" "lambda_zip" {
  type        = "zip"
  source_dir  = "${path.module}/lambda-code"
  output_path = "${path.module}/lambda-code/app_file.zip"
}
