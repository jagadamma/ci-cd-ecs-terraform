resource "aws_s3_bucket" "common_s3" {
  for_each = var.s3bucketslist

  bucket        = each.value.bucket_name
  force_destroy = each.value.force_destroy

  tags = merge(
    var.common_tags,
    {
      Name = each.value.bucket_name
    }
  )
}

resource "aws_s3_bucket_versioning" "s3_bucket_versioning" {
  for_each = var.s3bucketslist

  bucket = aws_s3_bucket.common_s3[each.key].id

  versioning_configuration {
    status = each.value.versioning ? "Enabled" : "Suspended"
  }
}

resource "aws_s3_bucket_public_access_block" "public_access_block" {
  for_each = {
    for k, v in var.s3bucketslist : k => v
    if !v.public_access
  }

  bucket = aws_s3_bucket.common_s3[each.key].id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

