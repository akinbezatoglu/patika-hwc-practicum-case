# Create ECS instance
data "huaweicloud_images_image" "os_image" {
  name        = var.ubuntu_img
  most_recent = true
}

resource "huaweicloud_compute_instance" "ecs" {
  name            = var.ecs_name
  image_id        = data.huaweicloud_images_image.os_image.id
  flavor_id       = var.ecs_flavor
  security_groups = [var.secgroup_name]
  key_pair        = var.keypair

  network {
    uuid = var.subnet_id
  }
}

# Create elastic ip address for ecs instance and associate to it
resource "huaweicloud_vpc_eip" "ecs_eip" {
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

resource "huaweicloud_compute_eip_associate" "ecs_eip_associated" {
  public_ip   = huaweicloud_vpc_eip.ecs_eip.address
  instance_id = huaweicloud_compute_instance.ecs.id
}