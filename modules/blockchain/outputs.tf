output "loadbalancer_security_group" {
  value = "${aws_security_group.loadbalancer_sg.id}"
}

# variable "loadbalancer_sg" {}

