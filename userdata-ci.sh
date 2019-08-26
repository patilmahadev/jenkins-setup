#!/bin/bash 

yum install java-1.8.0-openjdk docker git wget curl -y
rm -f /etc/alternatives/java
ln -s /usr/lib/jvm/jre-1.8.0-openjdk.x86_64/bin/java /etc/alternatives/java
wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
yum install jenkins -y
service jenkins start
wget https://packages.chef.io/files/stable/chefdk/4.3.13/el/6/chefdk-4.3.13-1.el6.x86_64.rpm
yum install chefdk-4.3.13-1.el6.x86_64.rpm -y
echo "Initial Admin Password: $(cat /var/lib/jenkins/secrets/initialAdminPassword)"