# vpc-peering module

The module provides a peering connection between VPCs and routing to each other with CIDR blocks. You can use the terraform **_for_each_** or **_count_** arguments to setup multiple peering connections.

## Resources
##### Click on the links for detailed descriptions of the resources.
* [huaweicloud_vpc_peering_connection](https://github.com/huaweicloud/terraform-provider-huaweicloud/blob/master/docs/resources/vpc_peering_connection.md)
* [huaweicloud_vpc_route](https://github.com/huaweicloud/terraform-provider-huaweicloud/blob/master/docs/resources/vpc_route.md)


## Usage
```
module "peering" {
  source              = "./modules/vpc-peering"
  count               = <numbers-of-peerings>(number)
  peering_name        = var.<your-all-peering-configs>.[count.index].name
  vpc_id              = var.<your-all-peering-configs>.[count.index].vpc_id
  peer_vpc_id         = var.<your-all-peering-configs>.[count.index].peer_vpc_id
  vpc_cidr_block      = var.<your-all-peering-configs>.[count.index].vpc_cidr_block
  peer_vpc_cidr_block = var.<your-all-peering-configs>.[count.index].peer_vpc_cidr_block
}
```