variable "multi_domain_cert" {
  type = object({
    domain_name               = string
    subject_alternative_names = list(string)
  })
}

variable "validation_method" {
  type = string
}

variable "hosted_zone_id" {
  type = string
}

variable "common_tags" {
  type    = map(string)
  default = {}
}
