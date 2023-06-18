#!/bin/bash
# Install Jenkins on Ubuntu 
# add the repository key to your system:
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key |sudo gpg --dearmor -o /usr/share/keyrings/jenkins.gpg

# append the Debian package repository address to the server
sudo sh -c 'echo deb [signed-by=/usr/share/keyrings/jenkins.gpg] http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'

# To use the new repository
sudo apt update -y

sudo apt install default-jre -y
sudo apt install default-jdk -y

# install Jenkins and its dependencies:
sudo apt install jenkins -y

# starting-jenkins
sudo systemctl start jenkins.service

# verify that Jenkins started successfully:
# sudo systemctl status jenkins
