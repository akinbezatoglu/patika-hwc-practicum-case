# vpc module

The module sets up a vpc and a subnet that belongs to this vpc. Also, you can set the CIDR block type, gateway IP, and DNS list of the vpc. You can use the terraform **_for_each_** or **_count_** arguments to setup multiple VPCs.

## Resources
##### Click on the links for detailed descriptions of the resources.
* [huaweicloud_vpc](https://github.com/huaweicloud/terraform-provider-huaweicloud/blob/master/docs/resources/vpc.md)
* [huaweicloud_vpc_subnet](https://github.com/huaweicloud/terraform-provider-huaweicloud/blob/master/docs/resources/vpc_subnet.md)


## Usage
```
module "vpc" {
  source            = "./modules/vpc"
  count             = <numbers-of-vpcs>(number)
  vpc_name          = var.<your-all-vpc-configs>.[count.index].name
  vpc_cidr_block    = var.<your-all-vpc-configs>.[count.index].cidr_block
  subnet_name       = var.<your-all-vpc-configs>.[count.index].subnet
  subnet_cidr_block = var.<your-all-vpc-configs>.[count.index].subnet_cidr_block
  subnet_gateway_ip = var.<your-all-vpc-configs>.[count.index].subnet_gateway_ip
  dns_list          = var.<your-all-vpc-configs>.dns_list
}
```