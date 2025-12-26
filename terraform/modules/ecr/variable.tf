variable "ecr_repositories" {
  type = list(object({
    name              = string
    enable_scanning   = bool
    tag_mutability    = string
    enable_encryption = bool
    enable_lifecycle  = bool
  }))
}

variable "kms_key_alias" {
  description = "Alias for the KMS key used to encrypt ECR repositories"
  type        = string
}

variable "lifecycle_policy" {
  description = "Lifecycle policy settings for ECR repositories"
  type = object({
    rulePriority = number
    description  = string
    tagStatus    = string
    countType    = string
    countNumber  = number
    actionType   = string
  })
}

variable "common_tags" {
  type        = map(string)
  default     = {}
}

variable "name_prefix" {
  description = "Name prefix for resources"
  type        = string
}
