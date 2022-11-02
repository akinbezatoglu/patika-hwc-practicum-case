variable "region" {
  default = "ap-southeast-1"
}

variable "availability_zones" {
  type    = list(string)
  default = ["ap-southeast-1a", "ap-southeast-1b"]
}

variable "auth_accesskey" {
  description = "The access key id of the user's account"
  type        = string
  sensitive   = true
}

variable "auth_secretkey" {
  description = "The secret key id of the user's account"
  type        = string
  sensitive   = true
}

variable "key_name" {
  type        = string
}

variable "public_key" {
  type        = string
}

variable "secg_name" {
  type    = string
  default = "secg-allow-all"
}

variable "secg_ingress_direct" {
  type    = string
  default = "ingress"
}

variable "ethertype" {
  type    = string
  default = "IPv4"
}

variable "all_ip_addr" {
  type    = string
  default = "0.0.0.0/0"
}

variable "vpc1" {
  type        = map(string)
  description = "(optional) describe your variable"
  default = {
    name              = "vpc-001",
    cidr_block        = "10.123.0.0/22"
    subnet            = "subnet-001"
    subnet_cidr_block = "10.123.0.0/24"
    subnet_gateway_ip = "10.123.0.1"
  }
}

variable "vpc2" {
  type        = map(string)
  description = "(optional) describe your variable"
  default = {
    name              = "vpc-002",
    cidr_block        = "10.10.12.0/22"
    subnet            = "subnet-002"
    subnet_cidr_block = "10.10.12.0/24"
    subnet_gateway_ip = "10.10.12.1"
  }
}

variable "vpc3" {
  type        = map(string)
  description = "(optional) describe your variable"
  default = {
    name              = "vpc-003",
    cidr_block        = "10.57.240.0/22"
    subnet            = "subnet-003"
    subnet_cidr_block = "10.57.240.0/24"
    subnet_gateway_ip = "10.57.240.1"
  }
}

variable "dns_list" {
  type    = list(string)
  default = ["100.125.1.250", "100.125.129.250"]
}

variable "ecs1_name" {
  type        = string
  description = "(optional) describe your variable"
  default     = "ecs-001"
}

variable "ecs2_name" {
  type        = string
  description = "(optional) describe your variable"
  default     = "ecs-002"
}

variable "ecs_flavor" {
  default = "s3.large.2"
}

variable "eip_bandwidth" {
  type        = map(string)
  description = "(optional) describe your variable"
  default = {
    publicip_type = "5_bgp"
    name          = "bw"
    size          = 8
    share_type    = "PER"
    charge_mode   = "traffic"
  }
}

variable "ubuntu_img" {
  type    = string
  default = "Ubuntu 18.04 server 64bit"
}

variable "rds1_name" {
  type    = string
  default = "rds-001"
}

variable "rds_flavor" {
  default = "rds.mysql.n1.large.2.ha"
}

variable "ha_replication_mode" {
  default = "semisync"
}

variable "db" {
  type        = map(string)
  description = "() describe your variable"
  default = {
    type        = "MySQL"
    version     = "5.7"
    volume_type = "CLOUDSSD"
    volume_size = "40"
  }
}

variable "db_password" {
  type = string
  description = "(optional) describe your variable"
}