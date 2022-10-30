# Reusable vpc module

# Create VPC
resource "huaweicloud_vpc" "vpc" {
  name  = var.vpc_name
  cidr  = var.vpc_cidr_block
}

# Create Subnet
resource "huaweicloud_vpc_subnet" "subnet" {
  vpc_id     = huaweicloud_vpc.vpc.id
  name       = var.subnet_name
  cidr       = var.subnet_cidr_block
  gateway_ip = var.subnet_gateway_ip
  dns_list   = var.dns_list
}