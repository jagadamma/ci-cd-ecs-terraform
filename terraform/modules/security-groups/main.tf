resource "aws_security_group_rule" "ingress" {
  for_each = var.security_group_rules

  type                     = "ingress"
  from_port                = each.value.from_port
  to_port                  = each.value.to_port
  protocol                 = each.value.protocol

  security_group_id         = var.target_security_group_id
  source_security_group_id = var.source_security_group_id
}

