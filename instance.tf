resource "aws_key_pair" "test-key" {
  key_name = "test-key"
  public_key = "${file("test-key.pub")}"
}

resource "aws_instance" "jenkins-ci" {
  ami = "${var.ami-id}"
  instance_type = "${var.instance-type}"
  key_name = "${aws_key_pair.test-key.id}"
  vpc_security_group_ids = ["${aws_security_group.jenkins-sg.id}"]
  subnet_id = "${aws_subnet.test-pub-sub.id}"
  user_data = "${file("userdata-ci.sh")}"
  tags = {
    Name = "jenkins-ci"
  }
}

resource "aws_instance" "docker-host" {
  ami = "${var.ami-id}"
  instance_type = "${var.instance-type}"
  key_name = "${aws_key_pair.test-key.id}"
  vpc_security_group_ids = ["${aws_security_group.docker-sg.id}"]
  subnet_id = "${aws_subnet.test-pri-sub.id}"
  user_data = "${file("userdata-app.sh")}"
  depends_on = ["aws_nat_gateway.test-ngw"]
  tags = {
    Name = "docker-host"
  }
}
