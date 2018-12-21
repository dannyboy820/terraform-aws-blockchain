resource "aws_ecs_cluster" "blockchain_cluster" {
  name = "${var.name_prefix}-${var.ecs_cluster_name}"
}

resource "aws_ecs_task_definition" "blockchain" {
  family                = "${var.name_prefix}_blockchain"
  container_definitions = "${var.container_definition}"

  lifecycle {
    create_before_destroy = true
  }
}

/* ECS service definition */
resource "aws_ecs_service" "service" {
  name            = "${var.name_prefix}_service"
  cluster         = "${aws_ecs_cluster.blockchain_cluster.id}"
  task_definition = "${aws_ecs_task_definition.blockchain.arn}"
  desired_count   = "${var.ecs_desired_count}"
  iam_role        = "${aws_iam_role.ecs_service_role.id}"

  load_balancer {
    target_group_arn = "${aws_alb_target_group.blockchain_tg.arn}"
    container_name   = "${var.name_prefix}-setup"
    container_port   = "${var.container_port}"
  }

  lifecycle {
    create_before_destroy = true
  }

  depends_on = ["aws_alb_listener.frontend_http"]
}
