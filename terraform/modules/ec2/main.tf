resource "aws_instance" "todo_ec2" {

  ami                    = var.ami_id
  subnet_id = var.subnet_id

  instance_type          = var.instance_type

  vpc_security_group_ids = [var.security_group_id]

  iam_instance_profile   = var.instance_profile

  user_data = templatefile("${path.module}/../../userdata.sh", {
    bucket_name = var.bucket_name
  })

  tags = {

    Name = "todo-app-server"

    Project = "Flask ToDo"

  }

}