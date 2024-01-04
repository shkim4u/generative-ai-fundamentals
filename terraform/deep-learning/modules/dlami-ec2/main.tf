resource "aws_security_group" "dlami_instance" {
  vpc_id = var.vpc_id
  name = "DLAMI-Instance-SecurityGroup"
  description = "Security group for a DLAMI instance"
}

resource "aws_security_group_rule" "dlami_instance_egress" {
  type = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.dlami_instance.id}"
}

resource "aws_security_group_rule" "dlami_instance_ingress" {
  type = "ingress"
  from_port = 8888
  to_port = 8888
  protocol = "TCP"
  security_group_id = "${aws_security_group.dlami_instance.id}"

  // Add source address to this security group
  cidr_blocks = ["0.0.0.0/0"]
}

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  name = "DLAMI-Instance"
  subnet_id = var.subnet_id
  iam_role_name = var.role_name
  # iam_instance_profile = var.instance_profile_name
  iam_instance_profile = var.instance_profile_arn
#  create_iam_instance_profile = true
  vpc_security_group_ids = ["${aws_security_group.dlami_instance.id}"]
  instance_type = "g5.16xlarge"
  ami = data.aws_ami.dlami_amazon_linux_2.id
  tags = {
    "Patch Group" = "AccountGuardian-PatchGroup-DO-NOT-DELETE"
  }
}

resource "aws_volume_attachment" "this" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.this.id
  instance_id = module.ec2_instance.id
}

resource "aws_ebs_volume" "this" {
  availability_zone = module.ec2_instance.availability_zone
  size              = 100
}