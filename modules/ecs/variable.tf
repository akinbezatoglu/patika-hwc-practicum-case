variable "secgroup_name" {}

variable "subnet_id" {}

variable "ecs_name" {}

variable "ecs_flavor" {}

variable "ubuntu_img" {}

variable "keypair_name" {}

variable "public_key" {}

variable "eip_bandwidth" {
    type = map(string)
}