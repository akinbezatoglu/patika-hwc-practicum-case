variable "rds_name" {}

variable "rds_flavor" {}

variable "ha_replication_mode" {}

variable "vpc_id" {}

variable "subnet_id" {}

variable "secgroup_id" {}

variable "availability_zones" {}

variable "db" {
    type = map(string)
}

variable "db_password" {}

variable "eip_bandwidth" {
    type = map(string)
}