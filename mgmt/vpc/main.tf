provider "aws" {
  region = "${var.aws_region}"
}

#Define VPC 
resource "aws_vpc" "default" {
  cidr_block           = "${var.vpc_cidr}"
  enable_dns_hostnames = true

  tags {
    Name = "test-vpc"
  }
}

# Define the internet gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.default.id}"

  tags {
    Name = "quidax IGW"
  }
}
