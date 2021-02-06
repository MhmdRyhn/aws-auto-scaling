#!/bin/bash

set -x
set -e

terraform init
terraform plan -var-file=input_value.tfvars -out tfplan
terraform apply tfplan
