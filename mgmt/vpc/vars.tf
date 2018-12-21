variable "name" {
  default = "staging"
}

variable "aws_region" {
  description = "Region for the VPC"
  default     = "eu-west-1"
}

variable "vpc_cidr" {
  description = "CIDR for the VPC"
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR for the public subnet"
  default     = "10.0.1.0/24"
}

variable "public_subnet_cidr_2" {
  description = "CIDR for the public subnet 2"
  default     = "10.0.2.0/24"
}

variable "private_subnet_cidr" {
  description = "CIDR for the private subnet"
  default     = "10.0.3.0/24"
}

variable "private_subnet_cidr_2" {
  description = "CIDR for the private subnet"
  default     = "10.0.4.0/24"
}

variable "key_path" {
  description = "SSH Public Key path"
  default     = "/home/core/.ssh/id_rsa.pub"
}
