variable "name_prefix" {
  type = string
}

variable "environment" {
  type = string
}

variable "region" {
  type = string
}

variable "service_role" {
  type = string
}

variable "ecr_repo_url" {
  type = string
}

variable "project_name" {
  type        = string
  description = "Base CodeBuild project name"
}

variable "service_name" {
  type        = string
  description = "Service name (app1, app2)"
}

variable "image_tag" {
  description = "Docker image tag"
  type        = string
}

variable "tags" {
  type = map(string)
}
