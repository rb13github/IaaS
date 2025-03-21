resource "tls_private_key" "ec2" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "ec2" {
  key_name   = "${var.project_name}-${var.env_type}-ec2-key"
  public_key = tls_private_key.ec2.public_key_openssh
}

resource "local_sensitive_file" "ec2-key" {
  content         = tls_private_key.ec2.private_key_openssh
  filename        = "${path.module}/id_rsa"
  file_permission = "0600"
}

resource "aws_instance" "ec2" {
  ami           = "ami-04b4f1a9cf54c11d0"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.ec2.key_name
  subnet_id     = data.aws_subnet.mainp_a.id
  security_groups = [ aws_security_group.ec2.id ]
  lifecycle {
    ignore_changes = [
        security_groups,
    ]
  }
}

resource "aws_security_group" "ec2" {
  name   = "${var.project_name}-${var.env_type}-ec2-sg"
  vpc_id = data.aws_vpc.mainp.id
}

resource "aws_security_group_rule" "sg_ingress_ec2_22" {
  security_group_id = aws_security_group.ec2.id
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "sg_egress_ec2" {
  security_group_id = aws_security_group.ec2.id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}