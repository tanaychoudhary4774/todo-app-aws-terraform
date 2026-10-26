output "public_ip" {

  value = aws_instance.todo_ec2.public_ip

}

output "instance_id" {

  value = aws_instance.todo_ec2.id

}