variable "ubuntu_img" {
  type    = string
  default = "Ubuntu 18.04 server 64bit"
}

variable "ecs_names" {
  type    = list(string)
  default = ["ecs-001", "ecs-002"]
}

variable "ecs_flavor" {
  default = "s3.large.2"
}

variable "publicip_type" {
  default = "5_bgp"
}

variable "eip_bandwith" {
  default = {
    name        = "bw"
    size        = 8
    share_type  = "PER"
    charge_mode = "traffic"
  }
}

variable "rds_name" {
  type    = string
  default = "rds-001"
}

variable "rds_flavor" {
  default = "rds.mysql.n1.large.2.ha"
}

variable "ha_replication_mode" {
  default = "semisync"
}

variable "db_type" {
  default = "MySQL"
}

variable "mysql_version" {
  default = "5.7"
}

variable "db_volume_type" {
  default = "CLOUDSSD"
}

variable "db_volume_size" {
  default = "40"
}
