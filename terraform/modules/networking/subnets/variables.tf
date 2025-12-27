
variable "environment" {
  type = string
}

variable "name_prefix" {
  description = "Prefix for naming resources"
  type        = string
}

variable "region" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "internet_gateway_id" {
  type = string
}

variable "nat_gateways" {
  type = list
}

variable "private_subnets" {
  type = list
}

#variable "db_subnets" {
#  type = list
#}
variable "public_subnets" {
  type = list
}

variable "private_subnet_route_tables" {
  type = list
}

variable "public_subnet_route_tables" {
  type = list
}

#variable "ecs_security_group_id" {
#  type = string
#}


#variable "db_subnet_route_tables" {
#  type = list
#}

variable "common_tags" {
  type        = map(string)
  default     = {}
}

variable "vpc_endpoint_sg_ingress" {
  type = list(object({
    from_port       = number
    to_port         = number
    protocol        = string
    cidr_blocks     = optional(list(string))
    security_groups = optional(list(string))
  }))
  default = []
}

variable "vpc_endpoint_sg_egress" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = []
}

