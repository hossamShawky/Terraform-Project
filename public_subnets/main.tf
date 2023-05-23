resource "aws_subnet" "public_subnets" {
  count             = length(var.public_cidrs)
  cidr_block        = var.public_cidrs[count.index]
  vpc_id            = var.vpc_id
  availability_zone = var.availability_zones[count.index]
  tags = {
    "Name" = var.public_names[count.index]
  }
}

resource "aws_route_table" "public_Rtable" {

  vpc_id = var.vpc_id
  route {
    cidr_block = var.destination
    gateway_id = var.igw_id
  }
  tags = {
    "Name" = "Public-RT"
  }
}

resource "aws_route_table_association" "public_subnets_RT_Associate" {
  count          = length(var.public_cidrs)
  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.public_Rtable.id
}



resource "aws_security_group" "public_security_gp" {
  vpc_id      = var.vpc_id
  name_prefix = "public_security_group"
  tags        = { "Name" : "public-SG" }

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
