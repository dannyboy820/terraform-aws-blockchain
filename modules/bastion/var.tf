variable "ssh_key_pair" {}

variable "ami_id" {
  default = "ami-466768ac"
}

variable "enable_ssh" {
  default = "false"
}

variable "vpc_id" {}

variable "public_subnet_id" {}
