
variable "name_prefix" {
  type = string
}

variable "environment" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "public_subnet_ids" {
  type = list(string)
}

variable "desired_count" {
  type = number
}

# variable "default_task_image" {
#   type    = string
#   default = null
# }


variable "alb_idle_timeout" {
  type = number
}

variable "assign_public_ip" {
  type = bool
}

#variable "execution_role_arn" {
#  type = string
#}

variable "tags" {
  type = map(string)
}

variable "ecs_security_group_ids" {
  type = list(string)
}

variable "alb_security_group_ids" {
  type = list(string)
}
variable "execution_role_arn" {
  description = "IAM role used by ECS agent to pull images, logs, etc"
  type        = string
  default     = null
}


# Multi-service ECS Task Definition List
variable "task_definition" {
  type = map(object({
    image  = optional(string)
    port   = number
    cpu    = number
    memory = number
  }))
}

#variable "task_role_arn" {
#  type = string
#}

variable "task_role_arn" {
  description = "IAM role assumed by the ECS task"
  type        = string
  default     = null
}
variable "listener_ports" {
  description = "ALB ports for prod and test listeners"
  type = object({
    prod = number
    test = number
  })
}

variable "listener_protocol" {
  description = "Listener protocol (HTTP/HTTPS)"
  type        = string
}

variable "health_check" {
  type = object({
    path                = string
    protocol            = string
    matcher             = string
    interval            = number
    timeout             = number
    healthy_threshold   = number
    unhealthy_threshold = number
  })
}

variable "traffic_weights" {
  type = object({
    blue  = number
    green = number
  })
}

