variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "app_port" {
  description = "Port on which the Flask app runs"
  type        = number
  default     = 5000
}