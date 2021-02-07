#!/bin/bash

set -x
set -e

cd terraform
terraform init
terraform plan -var-file=input_value.tfvars -out tfplan
terraform apply tfplan
# Destroy the infrastructure
# terraform plan -var-file=input_value.tfvars --auto-approve
