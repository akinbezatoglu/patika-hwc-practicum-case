# Security Group that allows for every incoming request.
resource "huaweicloud_networking_secgroup" "secgroup" {
  name = var.secg_name
}
resource "huaweicloud_networking_secgroup_rule" "rule" {
  security_group_id = huaweicloud_networking_secgroup.secgroup.id
  direction         = var.secg_ingress_direct
  ethertype         = var.ethertype
  remote_ip_prefix  = var.all_ip_addr
}

# Create VPCs
resource "huaweicloud_vpc" "vpcs" {
  count = length(var.vpc_names)
  name  = var.vpc_names[count.index]
  cidr  = var.vpc_cidr_blocks[count.index]
}

# Create Subnets
resource "huaweicloud_vpc_subnet" "subnets" {
  count      = length(var.subnet_names)
  vpc_id     = huaweicloud_vpc.vpcs[count.index].id
  name       = var.subnet_names[count.index]
  cidr       = var.subnet_cidr_blocks[count.index]
  gateway_ip = var.subnet_gateway_ips[count.index]
  dns_list   = var.dns_list
}
