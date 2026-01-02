resource "aws_s3_bucket" "s3_buckets" {
  for_each = var.bucket_configs
  bucket = each.value.s3_bucket_name

  tags = each.value.bucket_tags
}

resource "aws_s3_bucket_public_access_block" "block_public_access" {
  for_each = var.bucket_configs
  bucket = aws_s3_bucket.s3_buckets[each.key].id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

#bucket versioning
resource "aws_s3_bucket_versioning" "s3_buckets_versioning" {
  for_each = var.bucket_configs
  bucket = aws_s3_bucket.s3_buckets[each.key].id
  versioning_configuration {
    status = "Enabled"
  }
}
