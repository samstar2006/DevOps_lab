#! /bin/bash
export AWS_PROFILE=terraform_jenkins
terraform init
terraform fmt
terraform validate
terraform plan
terraform apply -auto-approve