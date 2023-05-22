output "private_subnet_ids" {
  value = aws_subnet.private_subnets[*].id
}

output "private_security_gp_id" {
  value = aws_security_group.private_security_gp.id
}

