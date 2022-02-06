output "endpoint" {
  value = aws_eks_cluster.eks.endpoint
}

output "eks_arn" {
  value = aws_iam_openid_connect_provider.eks.arn
}

output "iam_oidc_sub" {
  value = local.iam_oidc_sub
}

output "kubeconfig_ca_data" {
  value = aws_eks_cluster.eks.certificate_authority[0].data
}
