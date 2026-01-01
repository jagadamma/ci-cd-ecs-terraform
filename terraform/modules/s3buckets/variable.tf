variable "s3bucketslist" {
  description = "Map of S3 buckets keyed by logical name"
  type = map(object({
    bucket_name   = string
    force_destroy = bool
    versioning    = bool
    public_access = bool
  }))
}


variable "common_tags" {
  type        = map(string)
  default     = {}
}
