#!/bin/bash

# Update the system
yum update -y

# Install Git
yum install git -y

# Install Python 3
yum install python3 -y

# Install pip
yum install python3-pip -y

# Create application directory
mkdir -p /home/ec2-user/app

# Store the S3 bucket name passed from Terraform
echo "S3_BUCKET=${bucket_name}" > /home/ec2-user/app/.env

# Give ownership to ec2-user
chown -R ec2-user:ec2-user /home/ec2-user/app

echo "Setup completed successfully!"