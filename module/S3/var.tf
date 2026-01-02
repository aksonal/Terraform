variable "bucket_configs" {
  description = "S3 bucket configs info"
  type = map(object({
    s3_bucket_name = string
    bucket_tags = map(string)
  }))
}
