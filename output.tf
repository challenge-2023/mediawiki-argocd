output "eks-details" {
  value = data.aws_eks_cluster.this
  sensitive = true
}
output "eks-auth" {
  value = data.aws_eks_cluster_auth.this
  sensitive = true
}

output "myargo" {
  value = helm_release.argo-cd.manifest
  sensitive = false
}