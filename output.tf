output "jenkins-ci-url" {
  value = "http://${aws_instance.jenkins-ci.public_ip}:8080"
}
