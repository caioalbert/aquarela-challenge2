variable "region" {
  default = "us-east-2" # Alterado para us-east-2
}

variable "cluster_name" {
  default = "aquarela-eks-cluster"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}
