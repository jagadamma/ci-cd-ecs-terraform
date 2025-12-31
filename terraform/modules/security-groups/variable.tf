variable "security_group_rules" {
  description = "Ingress rules for the security group"
  type = map(object({
    from_port = number
    to_port   = number
    protocol  = string
  }))
}

variable "target_security_group_id" {
  type = string
}

variable "source_security_group_id" {
  type = string
}
