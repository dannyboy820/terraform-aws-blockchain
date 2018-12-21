resource "aws_instance" "bastion" {
  instance_type          = "t2.micro"
  ami                    = "${var.ami_id}"
  subnet_id              = "${var.public_subnet_id}"
  key_name               = "${var.ssh_key_pair}"
  vpc_security_group_ids = ["${aws_security_group.bastion_security_group.id}"]

  tags {
    Name = "Bastion Host"
  }
}
