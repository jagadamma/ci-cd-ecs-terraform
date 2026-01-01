output "bucket_names" {
  description = "Map of S3 bucket names keyed by logical name"
  value = {
    for k, v in aws_s3_bucket.common_s3 :
    k => v.bucket
  }
}

output "s3_bucket_arns" {
  description = "List of S3 bucket ARNs"
  value = [for b in aws_s3_bucket.common_s3 : b.arn]
}
