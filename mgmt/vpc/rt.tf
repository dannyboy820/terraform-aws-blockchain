resource "aws_route_table" "web-public-rt" {
  vpc_id = "${aws_vpc.default.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw.id}"
  }

  tags {
    Name = "Public Subnet RT"
  }
}

# Assign the route table to the public Subnet
resource "aws_route_table_association" "web-public-rt" {
  subnet_id      = "${aws_subnet.public-subnet.id}"
  route_table_id = "${aws_route_table.web-public-rt.id}"
}

resource "aws_route_table_association" "web-public-rt_2" {
  subnet_id      = "${aws_subnet.public-subnet_2.id}"
  route_table_id = "${aws_route_table.web-public-rt.id}"
}

resource "aws_route_table" "private_route_table" {
  vpc_id = "${aws_vpc.default.id}"

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.gw.id}"
  }

  tags {
    Name = "Private route table"
  }
}

# private subnet 2
resource "aws_route_table_association" "pr_2_subnet_association" {
  subnet_id      = "${aws_subnet.private-subnet_2.id}"
  route_table_id = "${aws_route_table.private_route_table.id}"
}

# private subnet 1
resource "aws_route_table_association" "pr_1_subnet_association" {
  subnet_id      = "${aws_subnet.private-subnet.id}"
  route_table_id = "${aws_route_table.private_route_table.id}"
}
