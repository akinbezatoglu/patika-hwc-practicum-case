# Create ECS instances in VPC1 and VPC2
data "huaweicloud_images_image" "os_image" {
  name        = var.ubuntu_img
  most_recent = true
}

resource "huaweicloud_compute_keypair" "keypair" {
  name       = var.keyname
  public_key = var.publickey
}

resource "huaweicloud_compute_instance" "ecs" {
  count           = length(var.ecs_names)
  name            = var.ecs_names[count.index]
  image_id        = data.huaweicloud_images_image.os_image.id
  flavor_id       = var.ecs_flavor
  security_groups = [huaweicloud_networking_secgroup.secgroup.name]
  key_pair        = huaweicloud_compute_keypair.keypair.name

  network {
    uuid = huaweicloud_vpc_subnet.subnets[count.index].id
  }
}

resource "huaweicloud_vpc_eip" "ecs_eips" {
  count = length(var.ecs_names)
  publicip {
    type = var.publicip_type
  }
  bandwidth {
    name        = var.eip_bandwith.name
    size        = var.eip_bandwith.size
    share_type  = var.eip_bandwith.share_type
    charge_mode = var.eip_bandwith.charge_mode
  }
}

resource "huaweicloud_compute_eip_associate" "ecs_eips_associated" {
  count       = length(var.ecs_names)
  public_ip   = huaweicloud_vpc_eip.ecs_eips[count.index].address
  instance_id = huaweicloud_compute_instance.ecs[count.index].id
}

# Create RDS instance in VPC3
resource "huaweicloud_rds_instance" "rds" {
  name                = var.rds_name
  flavor              = var.rds_flavor
  ha_replication_mode = var.ha_replication_mode
  vpc_id              = huaweicloud_vpc.vpcs[2].id
  subnet_id           = huaweicloud_vpc_subnet.subnets[2].id
  security_group_id   = huaweicloud_networking_secgroup.secgroup.id
  availability_zone = var.availability_zones
  db {
    type     = var.db_type
    version  = var.mysql_version
    password = var.mysql_psswd
  }
  volume {
    type = var.db_volume_type
    size = var.db_volume_size
  }
}

resource "huaweicloud_vpc_eip" "eip_rds" {
  publicip {
    type = var.publicip_type
  }
  bandwidth {
    name        = var.eip_bandwith.name
    size        = var.eip_bandwith.size
    share_type  = var.eip_bandwith.share_type
    charge_mode = var.eip_bandwith.charge_mode
  }
}

# get the port of rds instance by private_ip
data "huaweicloud_networking_port" "rds_port" {
  network_id = huaweicloud_vpc_subnet.subnets[2].id
  fixed_ip   = huaweicloud_rds_instance.rds.private_ips[0]
}

resource "huaweicloud_vpc_eip_associate" "rds_associated" {
  public_ip = huaweicloud_vpc_eip.eip_rds.address
  port_id   = data.huaweicloud_networking_port.rds_port.id
}
