# Reusable rds module

# Create RDS instance
resource "huaweicloud_rds_instance" "rds" {
  name                = var.rds_name
  flavor              = var.rds_flavor
  ha_replication_mode = var.ha_replication_mode
  vpc_id              = var.vpc_id
  subnet_id           = var.subnet_id
  security_group_id   = var.secgroup_id
  availability_zone = var.availability_zones
  db {
    type     = var.db.type
    version  = var.db.version
    password = var.db.password
  }
  volume {
    type = var.db.volume_type
    size = var.db.volume_size
  }
}

# Create elastic ip address for rds instance and associate to it
resource "huaweicloud_vpc_eip" "rds_eip" {
  publicip {
    type = var.eip_bandwidth.publicip_type
  }
  bandwidth {
    name        = var.eip_bandwidth.name
    size        = var.eip_bandwidth.size
    share_type  = var.eip_bandwidth.share_type
    charge_mode = var.eip_bandwidth.charge_mode
  }
}

# get the port of rds instance by private_ip
data "huaweicloud_networking_port" "rds_port" {
  network_id = var.subnet_id
  fixed_ip   = huaweicloud_rds_instance.rds.private_ips[0]
}

resource "huaweicloud_vpc_eip_associate" "rds_associated" {
  public_ip = huaweicloud_vpc_eip.rds_eip.address
  port_id   = data.huaweicloud_networking_port.rds_port.id
}