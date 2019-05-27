data "aws_route53_zone" "project_public_zone" {
  name = "${var.project_domain}."
  private_zone = false
}


resource "aws_route53_record" "bastion" {
  zone_id = "${data.aws_route53_zone.project_public_zone.zone_id}"
  name = "${var.project_name}-bastion.${data.aws_route53_zone.project_public_zone.name}"
  type = "A"
  alias {
    evaluate_target_health = true
    name = "${aws_lb.bastion.dns_name}"
    zone_id = "${aws_lb.bastion.zone_id}"
  }
}


