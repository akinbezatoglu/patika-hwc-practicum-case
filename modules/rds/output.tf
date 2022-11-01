output "rds_id" {
    value = huaweicloud_rds_instance.rds.id
}

output "rds_name" {
    value = huaweicloud_rds_instance.rds.name
}

output "eip" {
    value = huaweicloud_vpc_eip.rds_eip.address
}

output "private_ips" {
    value = huaweicloud_rds_instance.rds.private_ips
}