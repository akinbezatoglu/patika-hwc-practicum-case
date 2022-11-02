#!/bin/bash

BOLD_GREEN="\033[1;32m"
GREEN="\033[0;32m"
BOLD_RED="\033[1;31m"
NONE="\033[00m"

# Step 6
echo -e "${BOLD_GREEN}Create VPC-Peering between 1.VPC-2.VPC, 1.VPC-3.VPC and 2.VPC-3.VPC and adding routing rules to use VPC-Peerings${NONE}"
echo -e "${BOLD_RED}terraform apply -target=module.peering -auto-approve${NONE}"
terraform apply -target=module.peering -auto-approve

echo -e "${GREEN}Names of vpc-peering connections${NONE}"
terraform output peering_names

# Step 7
echo -e "${BOLD_GREEN}Remote Login to ECS and trying to ping other ECS and RDS${NONE}"
echo -e "${GREEN}Private IPs of ECSs${NONE}"
terraform output ecs_private_ips
echo -e "${GREEN}Private IPs of RDSs${NONE}"
terraform output rds_private_ips