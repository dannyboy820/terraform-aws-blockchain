resource "aws_security_group" "bastion_security_group" {
  name        = "bastion security group"
  description = "Allows"

  vpc_id = "${var.vpc_id}"

  #TODO change this to be disabled on production and
  # allow only user ip to be allowed

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
