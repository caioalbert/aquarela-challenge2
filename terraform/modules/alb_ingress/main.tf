resource "helm_release" "alb_ingress" {
  name       = "aws-load-balancer-controller"
  chart      = "aws-load-balancer-controller"
  repository = "https://aws.github.io/eks-charts"
  namespace  = "kube-system"

  values = [
    <<EOF
clusterName: ${var.cluster_name}
serviceAccount:
  create: false
  name: aws-load-balancer-controller
EOF
  ]
}
