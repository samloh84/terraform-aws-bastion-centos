// https://docs.aws.amazon.com/eks/latest/userguide/eks-optimized-ami.html

// https://www.terraform.io/docs/providers/aws/d/aws_ami.html
data "aws_ami" "centos" {
  most_recent = true
  executable_users = [
    "self"]

  filter {
    name = "product-code"
    values = [
      "aw0evgkw8e5c1q413zgy5pjce"]
  }

  filter {
    name = "owner-alias"
    values = [
      "aws-marketplace"]
  }

  owners = [
    "679593333241"
  ]
}

data "template_file" "user_data_bastion" {
  template = "${file("${path.module}/user_data_bastion.yml")}"
}


// https://www.terraform.io/docs/providers/aws/r/launch_template.html
resource "aws_launch_template" "bastion" {
  name_prefix = "${var.project_name}_bastion"
  image_id = "${data.aws_ami.centos.id}"
  instance_type = "t2.micro"
  vpc_security_group_ids = "${var.security_group_ids}"

  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      volume_size = "${var.volume_size}"
      delete_on_termination = true
    }
  }

  key_name = "${var.key_name}"

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "${var.owner_name}_bastion"
    }
  }

  credit_specification {
    cpu_credits = "unlimited"
  }

  tag_specifications {
    resource_type = "volume"
    tags = {
      Name = "${var.project_name}-bastion"
      Owner = "${var.owner_name}"
    }
  }

  tags = {
    Name = "${var.project_name}-bastion"
    Owner = "${var.owner_name}"
  }

  user_data = "${base64encode(data.template_file.user_data_bastion.rendered)}"
}

// https://www.terraform.io/docs/providers/aws/r/autoscaling_group.html
resource "aws_autoscaling_group" "bastion" {
  vpc_zone_identifier = "${var.subnet_ids}"
  desired_capacity = "1"
  max_size = "1"
  min_size = "1"

  launch_template {
    id = "${aws_launch_template.bastion.id}"
    version = "$Latest"
  }

}
