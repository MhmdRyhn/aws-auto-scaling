#!/bin/bash

set -x
set -e

cd terraform
terraform init
# terraform apply -var-file=input_value.tfvars --auto-approve // Shortcut, no plan file's created
terraform plan -var-file=input_value.tfvars -out tfplan
terraform apply tfplan
# Destroy the infrastructure
# terraform destroy -var-file=input_value.tfvars --auto-approve
