resource "aws_vpc" "dev-vpc" {
  cidr_block = var.cidr_block
  tags       = { "Name" : "dev-vpc" }
}

resource "aws_internet_gateway" "dev-igw" {
  vpc_id = aws_vpc.dev-vpc.id
  tags   = { "Name" : "dev-igw" }
}