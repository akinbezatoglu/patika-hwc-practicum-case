output "secg_rules" {
    value = huaweicloud_networking_secgroup.secgroup.rules
}

output "vpc_ids" {
    value = module.vpc[*].vpc_id
}

output "vpc_names" {
    value = module.vpc[*].vpc_name
}

output "vpc_cidr_blocks" {
    value = module.vpc[*].cidr
}

output "ecs_ids" {
    value = module.ecs[*].ecs_id
}

output "ecs_names" {
    value = module.ecs[*].ecs_name
}

output "ecs_public_ips" {
    value = module.ecs[*].eip
}

output "ecs_private_ips" {
    value = module.ecs[*].fixed_ip_v4
}

output "rds_ids" {
    value = module.rds[*].rds_id
}

output "rds_names" {
    value = module.rds[*].rds_name
}

output "rds_public_ips" {
    value = module.rds[*].eip
}

output "rds_private_ips" {
    value = module.rds[*].private_ips
}

output "peering_names" {
    value = module.peering[*].peering_name
}

output "keypair" {
    value = "./external/.ssh/${huaweicloud_compute_keypair.keypair.name}.pem"
}