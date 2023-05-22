module "VPC" {
  source = "./vpc_igw"
  cidr_block = "10.0.0.0/16"
}

module "Public_Subnets" {
  source = "./public_subnets"
  availability_zones = var.availability_zones
  public_cidrs = ["10.0.0.0/24","10.0.2.0/24"]
  public_names = ["public-subnet1","public-subnet2"]
  vpc_id = module.VPC.vpc_id
  igw_id=module.VPC.igw_id
  destination="0.0.0.0/0"

  depends_on = [ module.VPC ]
}

module "Private_Subnets" {
  source = "./private_subnets"
  availability_zones = var.availability_zones
  private_cidrs = ["10.0.1.0/24","10.0.3.0/24"]
  private_names = ["private-subnet1","private-subnet2"]
  vpc_id = module.VPC.vpc_id
  destination="0.0.0.0/0"
  public_subnet=module.Public_Subnets.public_subnet_ids[0]
  depends_on = [ module.Public_Subnets ]
}
module "Datasource_AMI" {
  source = "./datasource_ami"
  filter_names = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  filter_virtuals = ["hvm"]
  owners = ["099720109477"] # Canonical
}