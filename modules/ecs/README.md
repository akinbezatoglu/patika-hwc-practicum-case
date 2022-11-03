# ecs module

The module setup an ECS instance belonging to a specific subnet and opens it to the internet with EIP. You can use the terraform **_for_each_** or **_count_** arguments to setup multiple instances.

## Resources
##### Click on the links for detailed descriptions of the resources.
* [huaweicloud_compute_instance](https://github.com/huaweicloud/terraform-provider-huaweicloud/blob/master/docs/resources/compute_instance.md)
* [huaweicloud_vpc_eip](https://github.com/huaweicloud/terraform-provider-huaweicloud/blob/master/docs/resources/vpc_eip.md)
* [huaweicloud_compute_eip_associate](https://github.com/huaweicloud/terraform-provider-huaweicloud/blob/master/docs/resources/vpc_eip_associate.md)
* [huaweicloud_images_image](https://github.com/huaweicloud/terraform-provider-huaweicloud/blob/master/docs/resources/images_image.md)


## Usage
```
module "ecs" {
  source        = "./modules/ecs"
  count         = <numbers-of-instances>(number)
  secgroup_name = <your-security-group-name>(string)
  subnet_id     = var.<your-all-ecs-configs>[count.index].subnet_id
  ecs_name      = var.<your-all-ecs-configs>[count.index].name
  ecs_flavor    = <your-flavor-name>(string)
  os_img        = <your-image-name>(string)
  eip_bandwidth = var.<your-eip_bandwidth-configs>(map of any)
  keypair       = <your-keypair-file-name>(string)
}
```