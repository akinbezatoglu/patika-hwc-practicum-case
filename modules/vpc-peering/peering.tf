# Reusable peering connection module

# Create peering connection
resource "huaweicloud_vpc_peering_connection" "peering" {
  name        = var.peering_name
  vpc_id      = var.vpc_id
  peer_vpc_id = var.peer_vpc_id
}

resource "huaweicloud_vpc_route" "route1" {
  vpc_id      = var.vpc_id
  destination = var.peer_vpc_cidr_block
  type        = "peering"
  nexthop     = huaweicloud_vpc_peering_connection.peering.id
}
resource "huaweicloud_vpc_route" "route2" {
  vpc_id      = var.peer_vpc_id
  destination = var.vpc_cidr_block
  type        = "peering"
  nexthop     = huaweicloud_vpc_peering_connection.peering.id
}