#!/bin/bash
# add the user ansible admin
useradd ansibleadmin
# set password : the below command will avoid re entering the password
echo "ansibleansible" | passwd --stdin ansibleadmin
# modify the sudoers file at /etc/sudoers and add entry
echo 'ansibleadmin     ALL=(ALL)      NOPASSWD: ALL' | sudo tee -a /etc/sudoers
echo 'ec2-user     ALL=(ALL)      NOPASSWD: ALL' | sudo tee -a /etc/sudoers
# this command is to add an entry to file : echo 'PasswordAuthentication yes' | sudo tee -a /etc/ssh/sshd_config
# the below sed command will find and replace words with spaces "PasswordAuthentication no" to "PasswordAuthentication yes"
sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
service sshd restart
   
# Install docker
# Update the installed packages and package cache 
yum update -y
# Install the most recent Docker Engine package for Amazon Linux 2
yum install -y yum-utils device-mapper-persistent-data lvm2
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum install docker-ce -y
# Start the Docker service.
sudo systemctl start docker
sudo systemctl enable docker
# Add the ansibleadmin to the docker group so you can execute Docker commands without using sudo.
usermod -a -G docker ansibleadmin
# Configure Docker to start on boot
systemctl enable docker
# Install docker-py
yum install python3 -y
yum install python3-pip
pip3 install docker-py



