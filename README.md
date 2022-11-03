# patika-hwc-practicum-case

The case includes setup three VPCs on Huawei Cloud and creating ECS and RDS instances in them, and then establishing vpc-peering connections.


## Resuable Modules
* [vpc](https://github.com/akinbezatoglu/patika-hwc-practicum-case/tree/master/modules/vpc/README.md)
* [ecs](https://github.com/akinbezatoglu/patika-hwc-practicum-case/tree/master/modules/ecs/README.md)
* [rds](https://github.com/akinbezatoglu/patika-hwc-practicum-case/tree/master/modules/rds/README.md)
* [vpc-peering](https://github.com/akinbezatoglu/patika-hwc-practicum-case/tree/master/modules/vpc-peering/README.md)


## Usage
1. Create key pair file required for ssh connection to ECS instances.

```
. ./external/ssh-key-generator.sh
```

2. Add the environment variables created with the [**_ssh-key-generator.sh_**](https://github.com/akinbezatoglu/patika-hwc-practicum-case/blob/master/external/ssh-key-generator.sh) to the tfvars file.

```
echo "key_name=\"${fname}\"" >> terraform.auto.tfvars
echo "public_key=\"$(cat ${fpath}.pub)\"" >> terraform.auto.tfvars
```

3. Terraform commands that create VPCs, security group, ECS, and RDS instances, respectively.

```
terraform init
terraform plan
terraform apply -target=module.vpc
terraform apply -target=huaweicloud_networking_secgroup.secgroup
terraform apply -target=huaweicloud_networking_secgroup_rule.rule
terraform apply -target=module.ecs
terraform apply -target=module.rds
```

4. Reach out to the below terraform output values and ping the instances each other.

```
terraform output ecs_public_ips
terraform output rds_public_ips
terraform output keypair

ssh -i <path/to/your-keypair-file> root@<one-ipaddr-from-ecs_public_ips>
ping <another-ipaddr-from-ecs_public_ips>
ping <another-ipaddr-from-rds_public_ips>
```

5. Establish vpc-peering connections between VPCs. Reach out to the below terraform output values and ping the instances each other with private ip addresses.

```
terraform apply -target=module.peering -auto-approve

terraform output peering_names
terraform output ecs_private_ips
terraform output rds_private_ips

ssh -i <path/to/your-keypair-file> root@<one-ipaddr-from-ecs_private_ips>
ping <another-ipaddr-from-ecs_private_ips>
ping <another-ipaddr-from-rds_private_ips>
```