module "vpc" {
  source               = "./modules/vpc"
  vpc_name             = var.vpc_name
  cidr_block           = var.vpc_cidr_block
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
}

module "subnets" {
  source                  = "./modules/subnet"
  for_each                = var.subnets
  vpc_id                  = module.vpc.id
  cidr_block              = each.value.cidr_block
  availability_zone       = "${var.aws_region}${each.value.availability_zone}"
  map_public_ip_on_launch = each.value.type == "public" ? true : false
  tags = {
    Name                                               = "${var.eks_name}-${var.env}-${each.value.type}-${each.value.availability_zone}"
    "kubernetes.io/role/elb"                           = "1"
    "kubernetes.io/cluster/${var.env}-${var.eks_name}" = "owned"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = module.vpc.id

  tags = {
    Name = "public"
  }
}

resource "aws_route_table" "public" {
  vpc_id = module.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = {
    Name = "${var.env}-public"
  }
}

resource "aws_route_table_association" "association" {
  for_each       = var.subnets
  subnet_id      = module.subnets[each.key].id
  route_table_id = aws_route_table.public.id
}

variable "ecr_repository_name" {
  type        = string
  description = "ecr repository name"
}

