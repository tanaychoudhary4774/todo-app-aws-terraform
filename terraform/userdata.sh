#!/bin/bash

# Update system
yum update -y

# Install Git
yum install -y git

# Install Python 3 and pip
yum install -y python3 python3-pip

# Change to ec2-user home
cd /home/ec2-user

# Clone the repository
git clone https://github.com/ny1849288-dev/todo-app-aws-terraform.git

# Change ownership
chown -R ec2-user:ec2-user /home/ec2-user/todo-app-aws-terraform

# Move into Flask application
cd /home/ec2-user/todo-app-aws-terraform/flask

# Install Python dependencies
pip3 install -r requirements.txt

# Start Flask application
nohup python3 app.py > app.log 2>&1 &