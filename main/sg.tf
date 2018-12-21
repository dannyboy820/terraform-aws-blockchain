resource "aws_security_group" "ethereum_security_group" {
  name        = "ethereum_security_group"
  description = "Allows ssh only from bastion host and allows  load balancer  only to communicate to the rpc port"

  # TODO get private subnet vpc id from vpc module
  vpc_id = "${module.vpc.vpc_id}"

  # allow ssh from bastion host only 
  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = ["${module.bastion.bastion_security_group_id}"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
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

# create for others
resource "aws_security_group_rule" "allow_ethereum_load_balancer_security_group" {
  type      = "ingress"
  from_port = 8545
  to_port   = 8545
  protocol  = "tcp"

  # cidr_blocks = ["0.0.0.0/0"]
  source_security_group_id = "${module.ethereum.loadbalancer_security_group}"
  security_group_id        = "${aws_security_group.ethereum_security_group.id}"
}

resource "aws_security_group" "bitcoin_security_group" {
  name        = "bitcoin security group"
  description = "Allows ssh only from bastion host and allows  load balancer  only to communicate to the rpc port"

  # TODO get private subnet vpc id from vpc module
  vpc_id = "${module.vpc.vpc_id}"

  # change to allow from bastion host only 
  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = ["${module.bastion.bastion_security_group_id}"]
  }

  # TODO: this probably only needs egress to the ECS security group.
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group_rule" "allow_bitcoin_load_balancer_security_group" {
  type                     = "ingress"
  from_port                = 8332
  to_port                  = 8332
  protocol                 = "tcp"
  source_security_group_id = "${module.bitcoin.loadbalancer_security_group}"
  security_group_id        = "${aws_security_group.bitcoin_security_group.id}"
}

resource "aws_security_group" "bitcoin_cash_security_group" {
  name        = "bitcoin cash security group"
  description = "Allows ssh only from bastion host and allows  load balancer  only to communicate to the rpc port"
  # TODO get private subnet vpc id from vpc module
  vpc_id = "${module.vpc.vpc_id}"
  # change to allow from bastion host only 
  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = ["${module.bastion.bastion_security_group_id}"]
  }
  # TODO: this probably only needs egress to the ECS security group.
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_security_group_rule" "allow_bitcoin_cash_load_balancer_security_group" {
  type                     = "ingress"
  from_port                = 8332
  to_port                  = 8332
  protocol                 = "tcp"
  source_security_group_id = "${module.bitcoin_cash.loadbalancer_security_group}"
  security_group_id        = "${aws_security_group.bitcoin_cash_security_group.id}"
}
resource "aws_security_group" "bitcoin_gold_security_group" {
  name        = "bitcoin gold security group"
  description = "Allows ssh only from bastion host and allows  load balancer  only to communicate to the rpc port"
  # TODO get private subnet vpc id from vpc module
  vpc_id = "${module.vpc.vpc_id}"
  # change to allow from bastion host only 
  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = ["${module.bastion.bastion_security_group_id}"]
  }
  # TODO: this probably only needs egress to the ECS security group.
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_security_group_rule" "allow_bitcoin_gold_load_balancer_security_group" {
  type                     = "ingress"
  from_port                = 8332
  to_port                  = 8332
  protocol                 = "tcp"
  source_security_group_id = "${module.bitcoin_gold.loadbalancer_security_group}"
  security_group_id        = "${aws_security_group.bitcoin_gold_security_group.id}"
}


resource "aws_security_group" "ripple_security_group" {
  name        = "ripple security group"
  description = "Allows ssh only from bastion host and allows  load balancer  only to communicate to the rpc port"
  # TODO get private subnet vpc id from vpc module
  vpc_id = "${module.vpc.vpc_id}"
  # allow ssh from bastion host only 
  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = ["${module.bastion.bastion_security_group_id}"]
  }
  # TODO: this probably only needs egress to the ECS security group.
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_security_group_rule" "allow_ripple_load_balancer_security_group" {
  type                     = "ingress"
  from_port                = 51235
  to_port                  = 51235
  protocol                 = "tcp"
  source_security_group_id = "${module.ripple.loadbalancer_security_group}"
  security_group_id        = "${aws_security_group.ripple_security_group.id}"
}

