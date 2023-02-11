resource "kubernetes_namespace" "argocd" {
  metadata {
    name = var.argocd-namespace
  }
}
#resource "helm_release" "aws-elb" {
#  chart = "aws-load-balancer-controller"
#  name  = "aws-load-balancer-controller"
#  repository = "https://aws.github.io/eks-charts"
#  namespace = "kube-system"
#    values = [
#    "${file("alb-values.yaml")}"
#  ]
#  set {
#    name = "clusterName"
#    value = join("-", [var.cust_id, "eks"])
#  }
#  set {
#    name = "region"
#    value = var.region
#  }
#
#}

#module "eks-argocd" {
#  source  = "lablabs/eks-argocd/aws"
#  version = "0.1.3"
#  cluster_identity_oidc_issuer = data.aws_eks_cluster.this.identity[0].oidc[0].issuer
#  cluster_identity_oidc_issuer_arn = data.aws_eks_cluster.this.role_arn
#}
resource "helm_release" "argo-cd" {
  depends_on = [helm_release.aws-elb,kubernetes_namespace.argocd]
  chart = "argo-cd"
  name  = "argo-cd"
  repository = "https://argoproj.github.io/argo-helm"
  namespace = var.argocd-namespace
  values = [
    "${file("argo-values.yaml")}"
  ]
}