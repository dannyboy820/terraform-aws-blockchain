resource "aws_security_group" "loadbalancer_sg" {
  name        = "${var.name_prefix}-load_balancer"
  description = "Allows HTTP and HTTPS traffic"

  # TODO get private subnet vpc id from vpc module
  vpc_id = "${var.vpc_id}"

  # TODO: allow only requests from app servers
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # TODO: allow only requests from app servers
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # TODO: this probably only needs egress to the ECS security group.
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
