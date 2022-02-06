# Hello Terraform
This repository contains the infrastructure code necessary to run a hello world app on EKS.

To provision the infrastructure, run the following `terraform` commands:

```shell
terraform init -backend-config=_prod.tfbackend
terraform plan -var-file=_prod.tfvars
```
