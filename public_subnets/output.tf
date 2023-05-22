output "public_subnet_ids" {
  value = aws_subnet.public_subnets[*].id
}

output "public_security_gp_id" {
  value = aws_security_group.public_security_gp.id
}
