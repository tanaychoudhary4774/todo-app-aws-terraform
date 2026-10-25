variable "alert_email" {
  description = "Email address that receives CloudWatch alarm notifications"
  type        = string
  default     = "choudharytm@rknec.edu"
}

resource "aws_sns_topic" "alerts" {
  name = "todo-app-alerts"
}

resource "aws_sns_topic_subscription" "email" {
  topic_arn = aws_sns_topic.alerts.arn
  protocol  = "email"
  endpoint  = var.alert_email
}

output "sns_topic_arn" {
  value = aws_sns_topic.alerts.arn
}