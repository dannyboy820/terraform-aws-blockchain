# add bastion host security group
resource "aws_launch_configuration" "ecs" {
  name                 = "${var.name_prefix}-ECS-${var.ecs_cluster_name}"
  image_id             = "${lookup(var.amis, var.region)}"
  instance_type        = "${var.instance_type}"
  security_groups      = ["${var.instance_sg}"]
  iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

  # TODO: is there a good way to make the key configurable sanely?
  key_name                    = "${var.ssh_key_pair}"
  associate_public_ip_address = true
  user_data                   = "#!/bin/bash\necho ECS_CLUSTER='${var.name_prefix}-${var.ecs_cluster_name}' > /etc/ecs/ecs.config"

  root_block_device = {
    volume_size = "${var.volume_size}"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "ecs" {
  name                      = "${var.name_prefix} cluster"
  max_size                  = "${var.autoscale_max}"
  min_size                  = "${var.autoscale_min}"
  desired_capacity          = "${var.autoscale_desired}"
  health_check_grace_period = 300
  health_check_type         = "EC2"
  force_delete              = true
  launch_configuration      = "${aws_launch_configuration.ecs.name}"
  vpc_zone_identifier       = ["${split(",", var.private_subnets)}"]

  tag {
    key                 = "Name"
    value               = "${var.name_prefix} cluster"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}

# resource "aws_autoscaling_group" "ecs-cluster" {
#   availability_zones   = ["${var.availability_zone}"]
#   name                 = "ECS ${var.ecs_cluster_name}"
#   min_size             = "${var.autoscale_min}"
#   max_size             = "${var.autoscale_max}"
#   desired_capacity     = "${var.autoscale_desired}"
#   health_check_type    = "EC2"
#   launch_configuration = "${aws_launch_configuration.ecs.name}"


#   # TODO change this to match the private network VPC ID using output 
#   vpc_zone_identifier = ["${var.vpc_id}"]
# }

