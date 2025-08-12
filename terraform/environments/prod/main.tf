module "vpc" {
  source = "../../modules/vpc"
  name   = "aquarela-vpc"
  cidr   = "10.0.0.0/16"
  azs    = ["us-east-2a", "us-east-2b"] # Alterado para us-east-2
  public_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
}

module "eks" {
  source          = "../../modules/eks"
  cluster_name    = "aquarela-eks-cluster"
  cluster_version = "1.27"
  subnets         = module.vpc.public_subnets
  vpc_id          = module.vpc.vpc_id

  node_groups = {
    default = {
      desired_capacity = 2
      max_capacity     = 3
      min_capacity     = 1

      instance_type = "t3.medium"
    }
  }
}

module "alb_ingress" {
  source       = "../../modules/alb_ingress"
  cluster_name = module.eks.cluster_name
}
