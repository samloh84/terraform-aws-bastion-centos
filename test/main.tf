module "vpc" {
  source = "git::https://github.com/samloh84/terraform-aws-vpc-simple.git"
  vpc_cidr_block = "10.0.0.0/16"
  remote_management_cidrs = ["0.0.0.0/0"]
  vpc_name = "vpc-bastion"
  vpc_owner = "Samuel"
}

module "bastion-centos" {
  source = "../"

  key_name = "govtech-iacwg"
  lb_security_group_ids = ["${module.vpc.security_group_management_tier_id}"]
  lb_subnet_ids = "${module.vpc.subnet_management_tier_ids}"
  owner_name = "Samuel"
  project_domain = "govtech-iacwg.gdshive.com"
  project_name = "govtech-iacwg"
  security_group_ids = ["${module.vpc.security_group_management_tier_id}"]
  subnet_ids = "${module.vpc.subnet_management_tier_ids}"
  vpc_id = "${module.vpc.vpc_id}"
}