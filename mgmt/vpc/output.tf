output "vpc_id" {
  value = "${aws_vpc.default.id}"
}

output "private_subnet_id" {
  value = "${aws_subnet.private-subnet.id}"
}

output "private_subnet_id_2" {
  value = "${aws_subnet.private-subnet_2.id}"
}

output "public_subnet_id" {
  value = "${aws_subnet.public-subnet.id}"
}

output "public_subnet_id_2" {
  value = "${aws_subnet.public-subnet_2.id}"
}
