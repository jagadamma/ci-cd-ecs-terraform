
output "nat_gateway_ids" {
  value = aws_nat_gateway.nat_gateway.*.id
}
output "public_subnet_ids" {
  value = aws_subnet.public_subnets.*.id
}

output "private_subnet_ids" {
  value = aws_subnet.private_subnets.*.id
}

#output "db_subnet_ids" {
#  value = aws_subnet.db_subnets.*.id
#}

output "nat_gateway_public_ips" {
  value = [aws_eip.nat_eip.public_ip]
}

output "vpc_endpoints_sg_id" {
  description = "Security group ID for VPC interface endpoints"
  value       = aws_security_group.vpc_endpoints_sg.id
}

