resource "aws_subnet" "public-subnet" {
  vpc_id                  = "${aws_vpc.default.id}"
  cidr_block              = "${var.public_subnet_cidr}"
  availability_zone       = "eu-west-1a"
  map_public_ip_on_launch = true

  tags {
    Name = "Public Subnet"
  }
}

resource "aws_subnet" "public-subnet_2" {
  vpc_id                  = "${aws_vpc.default.id}"
  cidr_block              = "${var.public_subnet_cidr_2}"
  availability_zone       = "eu-west-1b"
  map_public_ip_on_launch = true

  tags {
    Name = "Public Subnet 2"
  }
}

# Define the private subnet
resource "aws_subnet" "private-subnet" {
  vpc_id            = "${aws_vpc.default.id}"
  cidr_block        = "${var.private_subnet_cidr}"
  availability_zone = "eu-west-1a"

  tags {
    Name = "Private Subnet"
  }
}

resource "aws_subnet" "private-subnet_2" {
  vpc_id            = "${aws_vpc.default.id}"
  cidr_block        = "${var.private_subnet_cidr_2}"
  availability_zone = "eu-west-1b"

  tags {
    Name = "Private Subnet 2"
  }
}
