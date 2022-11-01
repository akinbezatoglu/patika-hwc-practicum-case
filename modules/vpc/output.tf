output "vpc_id" {
    value = huaweicloud_vpc.vpc.id
}

output "vpc_name" {
    value = huaweicloud_vpc.vpc.name
}

output "cidr" {
    value = huaweicloud_vpc.vpc.cidr
}

output "subnet_id" {
    value = huaweicloud_vpc_subnet.subnet.id
}

output "subnet_name" {
    value = huaweicloud_vpc_subnet.subnet.name
}

output "subnet_cidr" {
    value = huaweicloud_vpc_subnet.subnet.cidr
}