# /// create a volume for these blockchains and mount it to them
# // launch this in a private subnet 
# // use an elb to point to to docker images
# // 

# // create ecs cluster
provider "aws" {
  region = "eu-west-1"
}

# resource "aws_security_group" "ecs" {
#   name        = "ecs"
#   description = "Allows all traffic"
#   vpc_id      = "${var.vpc_id}"

#   # TODO: remove this and replace with a bastion host for SSHing into
#   # individual machines.
#   ingress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   ingress {
#     from_port       = 0
#     to_port         = 0
#     protocol        = "-1"
#     security_groups = ["${aws_security_group.load_balancers.id}"]
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }

resource "aws_ecs_cluster" "blokchain_cluster" {
  name = "${var.name_prefix}-${var.ecs_cluster_name}"
}

resource "aws_iam_role" "ecs_host_role" {
  name               = "${var.name_prefix}-ecs_host_role"
  assume_role_policy = "${file("../modules/blockchain/policies/ecs-role.json")}"
}

resource "aws_iam_instance_profile" "ecs" {
  name = "${var.name_prefix}-ecs-instance-profile"
  path = "/"
  role = "${aws_iam_role.ecs_host_role.name}"
}

resource "aws_iam_role_policy" "ecs_instance_role_policy" {
  name   = "${var.name_prefix}-ecs_instance_role_policy"
  policy = "${file("../modules/blockchain/policies/ecs-instance-role-policy.json")}"
  role   = "${aws_iam_role.ecs_host_role.id}"
}

resource "aws_iam_role" "ecs_service_role" {
  name               = "${var.name_prefix}-ecs_service_role"
  assume_role_policy = "${file("../modules/blockchain/policies/ecs-role.json")}"
}

resource "aws_iam_role_policy" "ecs_service_role_policy" {
  name   = "${var.name_prefix}-ecs_service_role_policy"
  policy = "${file("../modules/blockchain/policies/ecs-service-role-policy.json")}"
  role   = "${aws_iam_role.ecs_service_role.id}"
}
