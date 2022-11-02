#!/bin/bash

BOLD_GREEN="\033[1;32m"
GREEN="\033[0;32m"
BOLD_RED="\033[1;31m"
NONE="\033[00m"

# SSH Keypair File
echo -e "${BOLD_GREEN}Creating ssh keypair file${NONE}"
echo -e "${BOLD_RED}. ./external/ssh-key-generator.sh${NONE}"
. ./external/ssh-key-generator.sh
echo "key_name=\"${fname}\"" >> terraform.auto.tfvars
echo "public_key=\"$(cat ${fpath}.pub)\"" >> terraform.auto.tfvars

# Terrform cli
echo -e "${BOLD_RED}terraform init${NONE}"
terraform init
echo -e "${BOLD_RED}terraform plan${NONE}"
terraform plan

# Step 1
echo -e "${BOLD_GREEN}Creating VPCs with different IP pool${NONE}"
echo -e "${BOLD_RED}terraform apply -target=module.vpc -auto-approve${NONE}"
terraform apply -target=module.vpc -auto-approve

echo -e "${GREEN}IDs of created VPCs${NONE}"
terraform output vpc_ids
echo -e "${GREEN}Names of created VPCs${NONE}"
terraform output vpc_names
echo -e "${GREEN}CIDR Blocks of created VPCs${NONE}"
terraform output vpc_cidr_blocks

# Step 2
echo -e "${BOLD_GREEN}Creating a Secuirty Group and allowing this security group for every incoming request${NONE}"
echo -e "${BOLD_RED}terraform apply -target=huaweicloud_networking_secgroup.secgroup -auto-approve${NONE}"
terraform apply -target=huaweicloud_networking_secgroup.secgroup -auto-approve
echo -e "${BOLD_RED}terraform apply -target=huaweicloud_networking_secgroup_rule.rule -auto-approve${NONE}"
terraform apply -target=huaweicloud_networking_secgroup_rule.rule -auto-approve
echo -e "${GREEN}Rules of the Security Group${NONE}"
terraform output secg_rules

# Step 3
echo -e "${BOLD_GREEN}Creating two ECS, one in 1. VPC one in 2. VPC${NONE}"
echo -e "${BOLD_RED}terraform apply -target=module.ecs -auto-approve${NONE}"
terraform apply -target=module.ecs -auto-approve
echo -e "${GREEN}IDs of created ECSs${NONE}"
terraform output ecs_ids
echo -e "${GREEN}Names of created ECSs${NONE}"
terraform output ecs_names
echo -e "${GREEN}Public IPs of created ECSs${NONE}"
terraform output ecs_public_ips
echo -e "${GREEN}Private IPs of created ECSs${NONE}"
terraform output ecs_private_ips

# Step 4
echo -e "${BOLD_GREEN}Using RDS, creating MySQL database in 3.VPC${NONE}"
echo -e "${BOLD_RED}terraform apply -target=module.rds -auto-approve${NONE}"
terraform apply -target=module.rds -auto-approve
echo -e "${GREEN}IDs of created RDSs${NONE}"
terraform output rds_ids
echo -e "${GREEN}Names of created RDSs${NONE}"
terraform output rds_names
echo -e "${GREEN}Public IPs of created RDSs${NONE}"
terraform output rds_public_ips
echo -e "${GREEN}Private IPs of created RDSs${NONE}"
terraform output rds_private_ips

# Step 5
echo -e "${BOLD_GREEN}Remote Login to ECS and trying to ping other ECS and RDS${NONE}"
echo -e "${GREEN}Public IPs of ECSs${NONE}"
terraform output ecs_public_ips
echo -e "${GREEN}Public IPs of RDSs${NONE}"
terraform output rds_public_ips
echo -e "${GREEN}Keypair name${NONE}"
terraform output keypair