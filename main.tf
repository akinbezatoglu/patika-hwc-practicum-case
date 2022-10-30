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

locals {
  vpcs = [var.vpc1, var.vpc2, var.vpc3]
}

module "vpc" {
  source            = "./modules/vpc"
  for_each          = local.vpcs
  vpc_name          = each.value.name
  vpc_cidr_block    = each.value.cidr_block
  subnet_name       = each.value.subnet
  subnet_cidr_block = each.value.subnet_cidr_block
  subnet_gateway_ip = each.value.subnet_gateway_ip
  dns_list          = var.dns_list
}

locals {
  ecs = [
    {
      name      = var.ecs1_name
      subnet_id = module.vpc[0].subnet_id
    },
    {
      name      = var.ecs2_name
      subnet_id = module.vpc[1].subnet_id
    }
  ]
}

module "ecs" {
  source        = "./modules/ecs"
  for_each      = local.ecs
  secgroup_name = var.secg_name
  subnet_id     = each.value.subnet_id
  ecs_name      = each.value.name
  ecs_flavor    = var.ecs_flavor
  ubuntu_img    = var.ubuntu_img
  keypair_name  = var.keypair_name
  public_key    = var.public_key
  eip_bandwidth = var.eip_bandwidth
}

locals {
  rds = [
    {
      name      = var.rds1_name
      vpc_id    = module.vpc[2].vpc_id
      subnet_id = module.vpc[2].subnet_id
    }
  ]
}

module "rds" {
  source              = "./modules/rds"
  for_each            = local.rds
  rds_name            = each.value.name
  rds_flavor          = var.rds_flavor
  ha_replication_mode = var.ha_replication_mode
  vpcs_id             = each.value.vpc_id
  subnet_id           = each.value.subnet_id
  secgroup_id         = huaweicloud_networking_secgroup.secgroup.id
  availability_zones  = var.availability_zones
  db                  = var.db
  eip_bandwidth       = var.eip_bandwidth
}

locals {
  peering = [
    {
      name                = "peering_${local.vpcs[0].name}_${local.vpcs[1].name}"
      vpc_id              = modules.vpc[0].vpc_id
      peer_vpc_id         = modules.vpc[1].vpc_id
      vpc_cidr_block      = local.vpcs[0].cidr_block
      peer_vpc_cidr_block = local.vpcs[1].cidr_block
    },
    {
      name                = "peering_${local.vpcs[0].name}_${local.vpcs[2].name}"
      vpc_id              = modules.vpc[0].vpc_id
      peer_vpc_id         = modules.vpc[2].vpc_id
      vpc_cidr_block      = local.vpcs[0].cidr_block
      peer_vpc_cidr_block = local.vpcs[2].cidr_block
    },
    {
      name                = "peering_${local.vpcs[1].name}_${local.vpcs[2].name}"
      vpc_id              = modules.vpc[1].vpc_id
      peer_vpc_id         = modules.vpc[2].vpc_id
      vpc_cidr_block      = local.vpcs[1].cidr_block
      peer_vpc_cidr_block = local.vpcs[2].cidr_block
    }
  ]
}

module "peering" {
  source              = "./modules/vpc-peering"
  for_each            = local.peering
  peering_name        = each.value.name
  vpc_id              = each.value.vpc_id
  peer_vpc_id         = each.value.peer_vpc_id
  vpc_cidr_block      = each.value.vpc_cidr_block
  peer_vpc_cidr_block = each.value.peer_vpc_cidr_block
}