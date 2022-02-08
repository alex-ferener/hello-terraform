resource "null_resource" "helm_install" {
  # Changes to the cluster requires re-provisioning
  triggers = {
    eks_arn = module.eks.eks_arn
  }

  provisioner "local-exec" {
    command = <<-SHELL
      aws eks update-kubeconfig --region ${var.aws_region} --name ${var.name}
      aws ecr-public get-login-password --region us-east-1 | helm registry login --username AWS --password-stdin public.ecr.aws
      helm upgrade --install ${var.name} ${var.chart_repo} --version ${var.chart_version}
      # wait a few seconds before requesting the endpoint in order to prevent a retrieval error
      sleep 5
    SHELL
  }

  depends_on = [aws_eks_node_group.node_group]
}

module "elb_endpoint" {
  source  = "matti/resource/shell"
  version = "1.5.0"

  triggers = {
    eks_arn = module.eks.eks_arn
  }

  command = "kubectl get svc --namespace default hello --template '{{ range (index .status.loadBalancer.ingress 0) }}{{.}}{{ end }}'"

  depends_on = [null_resource.helm_install]
}
