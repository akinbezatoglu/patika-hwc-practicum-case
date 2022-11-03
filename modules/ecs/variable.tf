variable "secgroup_name" {}

variable "subnet_id" {}

variable "ecs_name" {}

variable "ecs_flavor" {}

variable "os_img" {}

variable "eip_bandwidth" {
    type = map(string)
}

variable "keypair" {}