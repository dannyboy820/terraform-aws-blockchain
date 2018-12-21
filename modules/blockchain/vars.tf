variable "network" {
  description = "Should either be testnet or mainnet"
  default     = ""
}

variable "name_prefix" {}

variable "vpc_id" {}

variable "public_subnets" {}

variable "private_subnets" {}

# variable "subnet_ids" {}

# variable "loadbalancer_sg" {}
variable "instance_sg" {}

variable "volume_size" {
  default = "200"
}

variable "ecs_desired_count" {
  default = 1
}

variable "ecs_cluster_name" {
  # btc staging 
  description = "The name of the Amazon ECS cluster."
  default     = "staging"
}

variable "availability_zone" {
  description = "The availability zone"
  default     = "us-east-1a"
}

variable "amis" {
  description = "Which AMI to spawn. Defaults to the AWS ECS optimized images."

  # TODO: support other regions.
  default = {
    eu-west-1 = "ami-c91624b0"
    us-east-1 = "ami-c91624b0"
  }
}

variable "autoscale_min" {
  default     = "1"
  description = "Minimum autoscale (number of EC2)"
}

variable "autoscale_max" {
  default     = "3"
  description = "Maximum autoscale (number of EC2)"
}

variable "autoscale_desired" {
  default     = "1"
  description = "Desired autoscale (number of EC2)"
}

variable "instance_type" {
  default = "t2.large"
}

variable "region" {
  default = "eu-west-1"
}

variable "container_definition" {}
variable "container_port" {}

variable "ssh_key_pair" {}
