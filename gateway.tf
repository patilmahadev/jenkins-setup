resource "aws_internet_gateway" "test-igw" {
  vpc_id = "${aws_vpc.test-vpc.id}"
  tags = {
    Name = "test-igw"
  }
}

resource "aws_eip" "test-ip" {
  vpc = true
}

resource "aws_nat_gateway" "test-ngw" {
  allocation_id = "${aws_eip.test-ip.id}"
  subnet_id = "${aws_subnet.test-pub-sub.id}"
  depends_on = ["aws_internet_gateway.test-igw"]
  tags = {
    Name = "test-igw"
  }
}