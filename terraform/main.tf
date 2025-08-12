terraform {
  backend "s3" {
    bucket         = "terraform-desafio-aquarela"
    key            = "terraform/eks/terraform.tfstate"
    region         = "us-east-2"
  }
}

provider "aws" {
  region = "us-east-2"
}

module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = "aquarela-eks-cluster"
  cluster_version = "1.27"
  subnets         = module.vpc.public_subnets
  vpc_id          = module.vpc.vpc_id

  node_groups = {
    default = {
      desired_capacity = 2
      max_capacity     = 3
      min_capacity     = 1

      instance_type = "t3.small"
    }
  }
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  name    = "aquarela-vpc"
  cidr    = "10.0.0.0/16"
  azs     = ["us-east-1a", "us-east-1b"]
  public_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
}
