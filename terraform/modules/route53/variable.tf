variable "hosted_zones" {
  type = map(object({
    comment       = string
    force_destroy = bool
    private_zone  = bool
    vpc_ids       = optional(list(string))
  }))
}

variable "records" {
  type = map(object({
    zone_name = string
    name      = string
    type      = string
    records   = optional(list(string))
    ttl       = optional(number)
    alias = optional(object({
      name                   = string
      zone_id                = string
      evaluate_target_health = bool
    }))
  }))
}


variable "common_tags" {
  type = map(string)
}
