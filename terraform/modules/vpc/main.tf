module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  name    = var.name
  cidr    = var.cidr
  azs     = var.azs
  public_subnets = var.public_subnets
}

resource "aws_internet_gateway" "igw" {
  vpc_id = module.vpc.vpc_id
}

resource "aws_route_table" "public" {
  vpc_id = module.vpc.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource
