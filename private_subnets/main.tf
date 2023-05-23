resource "aws_subnet" "private_subnets" {
  count             = length(var.private_cidrs)
  cidr_block        = var.private_cidrs[count.index]
  vpc_id            = var.vpc_id
  availability_zone = var.availability_zones[count.index]
  tags = {
    "Name" = var.private_names[count.index]
  }
}

resource "aws_route_table" "private_Rtable" {

  vpc_id = var.vpc_id
  route {
    cidr_block = var.destination
    gateway_id = aws_nat_gateway.NAT.id

  }

  tags = {
    "Name" = "Public-RT"
  }

}

resource "aws_route_table_association" "private_subnets_RT_Associate" {
  count          = length(var.private_cidrs)
  subnet_id      = aws_subnet.private_subnets[count.index].id
  route_table_id = aws_route_table.private_Rtable.id
}

resource "aws_security_group" "private_security_gp" {
  vpc_id      = var.vpc_id
  name_prefix = "private_security_group"
  tags        = { "Name" : "private-SG" }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }



}


resource "aws_eip" "EIP" {
  vpc = true
}

resource "aws_nat_gateway" "NAT" {
  allocation_id = aws_eip.EIP.id
  subnet_id     = var.public_subnet
}