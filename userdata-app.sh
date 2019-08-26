#!/bin/bash 

yum install docker git wget curl -y
service docker start

wget https://packages.chef.io/files/stable/chefdk/4.3.13/el/6/chefdk-4.3.13-1.el6.x86_64.rpm
yum install chefdk-4.3.13-1.el6.x86_64.rpm -y