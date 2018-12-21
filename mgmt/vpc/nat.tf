resource "aws_nat_gateway" "gw" {
  allocation_id = "${aws_eip.nat.id}"
  depends_on    = ["aws_internet_gateway.gw"]

  #   modify for the first item in the subnet

  subnet_id = "${aws_subnet.public-subnet.id}"
  tags {
    Name = "${var.name}"
  }
}
