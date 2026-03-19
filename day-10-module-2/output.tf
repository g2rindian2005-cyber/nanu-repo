output "instance_id" {
  value = aws_instance.name
}

output "public_ip" {
  value = aws_instance.name.public_ip
}