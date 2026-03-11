output "dev_instance_id" {
  description = "Dev account EC2 instance ID"
  value       = aws_instance.dev.id
}

output "dev_instance_public_ip" {
  description = "Dev account EC2 instance public IP"
  value       = aws_instance.dev.public_ip
}

output "test_instance_id" {
  description = "Test account EC2 instance ID"
  value       = aws_instance.test.id
}

output "test_instance_public_ip" {
  description = "Test account EC2 instance public IP"
  value       = aws_instance.test.public_ip
}
