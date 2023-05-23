output "vpc_id" {
  value = aws_vpc.dev-vpc.id
}
output "igw_id" {
  value = aws_internet_gateway.dev-igw.id
}