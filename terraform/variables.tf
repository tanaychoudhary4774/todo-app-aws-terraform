variable "aws_region" {

  description = "AWS Region"

  type = string

  default = "us-west-1"

}

variable "instance_type" {

  description = "EC2 Instance Type"

  type = string

  default = "t3.micro"

}

variable "ami_id" {

  description = "Amazon Linux AMI"

  type = string

}

variable "bucket_name" {

  description = "S3 Bucket Name"

  type = string

}