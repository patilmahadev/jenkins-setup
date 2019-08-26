resource "aws_vpc" "test-vpc" {
  cidr_block = "172.20.0.0/16"
  tags = {
    Name = "test-vpc"
  }
}

resource "aws_subnet" "test-pub-sub" {
  vpc_id = "${aws_vpc.test-vpc.id}"
  cidr_block = "172.20.10.0/24"
  availability_zone = "${var.region}a"
  map_public_ip_on_launch = true
  tags = {
    Name = "test-pub-sub"
  }
}

resource "aws_subnet" "test-pri-sub" {
  vpc_id = "${aws_vpc.test-vpc.id}"
  cidr_block = "172.20.20.0/24"
  availability_zone = "${var.region}b"
  tags {
    Name = "test-pri-sub"
  }
}

resource "aws_route_table" "test-pub-rt" {
  vpc_id = "${aws_vpc.test-vpc.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.test-igw.id}"
  }
  tags = {
    Name = "test-pub-rt"
  }
}

resource "aws_route_table" "test-pri-rt" {
  vpc_id = "${aws_vpc.test-vpc.id}"
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id  = "${aws_nat_gateway.test-ngw.id}"
  }
  tags {
    Name = "test-pri-rt"
  }
}

resource "aws_route_table_association" "test-pub-rt-asso" {
  subnet_id = "${aws_subnet.test-pub-sub.id}"
  route_table_id = "${aws_route_table.test-pub-rt.id}"
}

resource "aws_route_table_association" "test-pri-rt-asso" {
  subnet_id = "${aws_subnet.test-pri-sub.id}"
  route_table_id = "${aws_route_table.test-pri-rt.id}"
}