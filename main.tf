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
  count             = length(local.vpcs)
  vpc_name          = local.vpcs[count.index].name
  vpc_cidr_block    = local.vpcs[count.index].cidr_block
  subnet_name       = local.vpcs[count.index].subnet
  subnet_cidr_block = local.vpcs[count.index].subnet_cidr_block
  subnet_gateway_ip = local.vpcs[count.index].subnet_gateway_ip
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
  count         = length(local.ecs)
  secgroup_name = var.secg_name
  subnet_id     = local.ecs[count.index].subnet_id
  ecs_name      = local.ecs[count.index].name
  ecs_flavor    = var.ecs_flavor
  ubuntu_img    = var.ubuntu_img
  keypair_name  = data.external.ssh.result.key_name
  public_key    = data.external.ssh.result.public_key
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
  count               = length(local.rds)
  rds_name            = local.rds[count.index].name
  rds_flavor          = var.rds_flavor
  ha_replication_mode = var.ha_replication_mode
  vpc_id              = local.rds[count.index].vpc_id
  subnet_id           = local.rds[count.index].subnet_id
  secgroup_id         = huaweicloud_networking_secgroup.secgroup.id
  availability_zones  = var.availability_zones
  db                  = var.db
  db_password         = var.db_password
  eip_bandwidth       = var.eip_bandwidth
}

locals {
  peering = [
    {
      name                = "peering_${local.vpcs[0].name}_${local.vpcs[1].name}"
      vpc_id              = module.vpc[0].vpc_id
      peer_vpc_id         = module.vpc[1].vpc_id
      vpc_cidr_block      = local.vpcs[0].cidr_block
      peer_vpc_cidr_block = local.vpcs[1].cidr_block
    },
    {
      name                = "peering_${local.vpcs[0].name}_${local.vpcs[2].name}"
      vpc_id              = module.vpc[0].vpc_id
      peer_vpc_id         = module.vpc[2].vpc_id
      vpc_cidr_block      = local.vpcs[0].cidr_block
      peer_vpc_cidr_block = local.vpcs[2].cidr_block
    },
    {
      name                = "peering_${local.vpcs[1].name}_${local.vpcs[2].name}"
      vpc_id              = module.vpc[1].vpc_id
      peer_vpc_id         = module.vpc[2].vpc_id
      vpc_cidr_block      = local.vpcs[1].cidr_block
      peer_vpc_cidr_block = local.vpcs[2].cidr_block
    }
  ]
}

module "peering" {
  source              = "./modules/vpc-peering"
  count               = length(local.peering)
  peering_name        = local.peering[count.index].name
  vpc_id              = local.peering[count.index].vpc_id
  peer_vpc_id         = local.peering[count.index].peer_vpc_id
  vpc_cidr_block      = local.peering[count.index].vpc_cidr_block
  peer_vpc_cidr_block = local.peering[count.index].peer_vpc_cidr_block
}