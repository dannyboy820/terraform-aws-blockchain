resource "aws_alb" "main" {
  lifecycle {
    create_before_destroy = true
  }

  name            = "${var.name_prefix}-blockchain"
  subnets         = ["${split(",", var.public_subnets)}"]
  security_groups = ["${aws_security_group.loadbalancer_sg.id}"]
  idle_timeout    = 400

  tags {
    Name = "${var.name_prefix}_blockchain"
  }
}

resource "aws_alb_target_group" "blockchain_tg" {
  name     = "${var.name_prefix}-blockchain"
  port     = "${var.container_port}"
  protocol = "HTTP"
  vpc_id   = "${var.vpc_id}"

  deregistration_delay = 180

  health_check {
    interval            = "60"
    path                = "/"
    port                = "${var.container_port}"
    healthy_threshold   = "3"
    unhealthy_threshold = "3"
    timeout             = "5"
    protocol            = "HTTP"
  }

  tags {
    Name = "${var.name_prefix}_blockchain"
  }

  depends_on = ["aws_alb.main"]
}

resource "aws_alb_listener" "frontend_http" {
  load_balancer_arn = "${aws_alb.main.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_alb_target_group.blockchain_tg.id}"
    type             = "forward"
  }

  depends_on = ["aws_alb.main"]
}
