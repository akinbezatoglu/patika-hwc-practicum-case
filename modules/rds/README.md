# rds module

The module setup an RDS instance that belongs to a specific subnet, vpc, and security group where you can set the database type, version, and volume. The module also opens it to the internet with EIP. You can use the terraform **_for_each_** or **_count_** arguments to setup multiple instances.

## Resources
##### Click on the links for detailed descriptions of the resources.
* [huaweicloud_rds_instance](https://github.com/huaweicloud/terraform-provider-huaweicloud/blob/master/docs/resources/rds_instance.md)
* [huaweicloud_vpc_eip](https://github.com/huaweicloud/terraform-provider-huaweicloud/blob/master/docs/resources/vpc_eip.md)
* [huaweicloud_vpc_eip_associate](https://github.com/huaweicloud/terraform-provider-huaweicloud/blob/master/docs/resources/vpc_eip_associate.md)
* [huaweicloud_networking_port](https://github.com/huaweicloud/terraform-provider-huaweicloud/blob/master/docs/resources/networking_port_v2.md)


## Usage
```
module "rds" {
  source              = "./modules/rds"
  count               = <numbers-of-instances>(number)
  rds_name            = var.<your-all-rds-configs>.name(string)
  rds_flavor          = <your-flavor-name>(string)
  ha_replication_mode = var.ha_replication_mode(string)
  vpc_id              = var.<your-all-rds-configs>[count.index].vpc_id
  subnet_id           = var.<your-all-rds-configs>[count.index].subnet_id
  secgroup_id         = var.secgroup_id(string)
  availability_zones  = var.availability_zones(list of strings)
  db                  = var.db(map of strings)
  db_password         = var.db_password(string)
  eip_bandwidth       = var.<your-eip_bandwidth-configs>(map of any)
}
```