resource "aws_eks_node_group" "node_group" {
  cluster_name    = var.name
  node_group_name = "private"
  node_role_arn   = aws_iam_role.node_group.arn
  subnet_ids      = values(module.vpc.private_subnets)
  instance_types  = ["m6i.large"]

  scaling_config {
    desired_size = 3
    max_size     = 12
    min_size     = 3
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    module.eks.eks_arn,
    aws_iam_role_policy_attachment.worker_node_policy,
    aws_iam_role_policy_attachment.cni_policy,
    aws_iam_role_policy_attachment.container_registry,
  ]

  lifecycle {
    ignore_changes = [scaling_config[0].desired_size]
  }

  tags = var.tags
}
