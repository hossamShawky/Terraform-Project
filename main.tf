module "VPC" {
  source     = "./vpc_igw"
  cidr_block = "10.0.0.0/16"
}

module "Public_Subnets" {
  source             = "./public_subnets"
  availability_zones = var.availability_zones
  public_cidrs       = ["10.0.0.0/24", "10.0.2.0/24"]
  public_names       = ["public-subnet1", "public-subnet2"]
  vpc_id             = module.VPC.vpc_id
  igw_id             = module.VPC.igw_id
  destination        = "0.0.0.0/0"

  depends_on = [module.VPC]
}

module "Private_Subnets" {
  source             = "./private_subnets"
  availability_zones = var.availability_zones
  private_cidrs      = ["10.0.1.0/24", "10.0.3.0/24"]
  private_names      = ["private-subnet1", "private-subnet2"]
  vpc_id             = module.VPC.vpc_id
  destination        = "0.0.0.0/0"
  public_subnet      = module.Public_Subnets.public_subnet_ids[0]
  depends_on         = [module.Public_Subnets]
}
module "Datasource_AMI" {
  source          = "./datasource_ami"
  filter_names    = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  filter_virtuals = ["hvm"]
  owners          = ["099720109477"] # Canonical
}

module "Private_Apache" {
  source              = "./private_apache"
  ami_id              = module.Datasource_AMI.ami_id
  private_subnets_ids = module.Private_Subnets.private_subnet_ids
  securit_group_ids   = module.Private_Subnets.private_security_gp_id
  instance_type       = "t2.micro"
}

module "Private_LoadBalancer" {
  source          = "./private_loadbalancer"
  vpc_id          = module.VPC.vpc_id
  apache_ids      = module.Private_Apache.apache_server_ids
  lb_security_gps = [module.Public_Subnets.public_security_gp_id]
  lb_subnets      = module.Private_Subnets.private_subnet_ids
  depends_on      = [module.Private_Apache]
}

module "Public_Nginx" {
  source                    = "./public_nginx"
  ami_id                    = module.Datasource_AMI.ami_id
  private_load_balancer_dns = module.Private_LoadBalancer.private_loadbalancer_dns
  public_subnets_ids        = module.Public_Subnets.public_subnet_ids
  securit_group_ids         = module.Public_Subnets.public_security_gp_id
  instance_type             = "t2.micro"
  depends_on                = [module.Private_LoadBalancer]
}

module "Public_LoadBalancer" {
  source          = "./public_loadbalancer"
  vpc_id          = module.VPC.vpc_id
  nginx_ids       = module.Public_Nginx.nginx_proxy_ids
  lb_security_gps = [module.Public_Subnets.public_security_gp_id]
  lb_subnets      = module.Public_Subnets.public_subnet_ids
  depends_on      = [module.Public_Nginx]
}
