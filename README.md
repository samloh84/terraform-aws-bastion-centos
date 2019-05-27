# Terraform AWS Bastion - Centos

Terraform module for creating an Autoscaling group to create a CentOS Bastion on AWS. 

## Usage

```hcl-terraform
module "bastion-centos" {
  source = "git::https://github.com/samloh84/terraform-aws-bastion-centos.git"
  owner_name = "Samuel"
  subnet_ids = "${module.vpc.security_group_management_tier_ids}"
  lb_subnet_ids = "${module.vpc.security_group_management_tier_ids}"
  project_name = "Example Project"
  key_name = "example_key"
  vpc_id = "${module.vpc.vpc_id}"
  security_group_ids = "${module.vpc.security_group_management_tier_ids}"
  lb_security_group_ids = "${module.vpc.security_group_management_tier_ids}"
  project_domain = "example.com"
  volume_size = "20"
}
```

## License
[MIT](https://choosealicense.com/licenses/mit/)
