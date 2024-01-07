# terraform remote backend
terraform {
  backend "s3" {
    bucket = "terraform-backend-test11"
    key    = "tf-backend"
    region = "us-east-1"
    dynamodb_table = "terraform-lock" # lock table name in dynamodb
  }
}

