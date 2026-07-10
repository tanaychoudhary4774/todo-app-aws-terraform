variable "ami_id" {
  description = "Amazon Linux AMI ID"
  type        = string
}

variable "instance_type" {
  description = "EC2 Instance Type"
  type        = string
}

variable "security_group_id" {
  description = "Security Group ID"
  type        = string
}

variable "instance_profile" {
  description = "IAM Instance Profile"
  type        = string
}

variable "bucket_name" {
  description = "S3 Bucket Name"
  type        = string
}
variable "subnet_id" {
  description = "Subnet ID"
  type        = string
}