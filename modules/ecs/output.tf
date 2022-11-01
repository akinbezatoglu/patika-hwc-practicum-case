output "keypair_name" {
    value = huaweicloud_compute_instance.ecs.key_pair
}

output "ecs_id" {
    value = huaweicloud_compute_instance.ecs.id
}

output "ecs_name" {
    value = huaweicloud_compute_instance.ecs.name
}

output "fixed_ip_v4" {
    value = huaweicloud_compute_instance.ecs.network[0].fixed_ip_v4
}

output "eip" {
    value = huaweicloud_vpc_eip.ecs_eip.address
}