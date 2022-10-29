# VPC PEERING
resource "huaweicloud_vpc_peering_connection" "peering1" {
  name        = "vpc1-vpc2"
  vpc_id      = huaweicloud_vpc.vpcs[0].id
  peer_vpc_id = huaweicloud_vpc.vpcs[1].id
}
resource "huaweicloud_vpc_route" "route1" {
  vpc_id      = huaweicloud_vpc.vpcs[0].id
  destination = var.vpc_cidr_blocks[1]
  type        = "peering"
  nexthop     = huaweicloud_vpc_peering_connection.peering1.id
}
resource "huaweicloud_vpc_route" "route2" {
  vpc_id      = huaweicloud_vpc.vpcs[1].id
  destination = var.vpc_cidr_blocks[0]
  type        = "peering"
  nexthop     = huaweicloud_vpc_peering_connection.peering1.id
}
