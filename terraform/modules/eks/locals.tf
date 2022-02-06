locals {
  iam_oidc_sub = "${replace(aws_iam_openid_connect_provider.eks.url, "https://", "")}:sub"
}
