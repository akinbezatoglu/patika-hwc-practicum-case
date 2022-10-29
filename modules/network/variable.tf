variable "secg_name" {
  type    = string
  default = "secg-allow-all"
}

variable "vpc_names" {
  type    = list(string)
  default = ["vpc-001", "vpc-002", "vpc-003"]
}

variable "vpc_cidr_blocks" {
  type    = list(string)
  default = ["10.123.0.0/22", "10.10.12.0/22", "10.57.240.0/22"]
}

variable "subnet_names" {
  type    = list(string)
  default = ["subnet-001", "subnet-002", "subnet-003"]
}

variable "subnet_cidr_blocks" {
  type    = list(string)
  default = ["10.123.0.0/24", "10.10.12.0/24", "10.57.240.0/24"]
}

variable "subnet_gateway_ips" {
  type    = list(string)
  default = ["10.123.0.1", "10.10.12.1", "10.57.240.1"]
}

variable "dns_list" {
  type    = list(string)
  default = ["100.125.1.250", "100.125.129.250"]
}

variable "ethertype" {
  type    = string
  default = "IPv4"
}

variable "all_ip_addr" {
  type    = string
  default = "0.0.0.0/0"
}

variable "secg_ingress_direct" {
  type = string
  default = "ingress"
}
