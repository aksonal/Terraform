output "bucket_id" {
  description = "Map of bucket id's"
  value = {
    for k,v in aws_s3_bucket.s3_buckets : 
    k => v.id
  }
}
