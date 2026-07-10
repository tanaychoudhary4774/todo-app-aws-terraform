resource "aws_security_group" "todo_sg" {

  name        = "todo-app-security-group"

  description = "Security Group for Flask ToDo App"
  vpc_id = var.vpc_id

  ingress {

    description = "Flask Application"

    from_port = var.app_port

    to_port = var.app_port
   
    protocol = "tcp"

    cidr_blocks = ["0.0.0.0/0"]

  }

  egress {

    from_port = 0

    to_port = 0

    protocol = "-1"

    cidr_blocks = ["0.0.0.0/0"]

  }

  tags = {

    Name = "todo-app-security-group"

  }

}