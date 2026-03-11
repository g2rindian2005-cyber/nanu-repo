# EC2 Instance in Dev Account
resource "aws_instance" "dev" {
  provider      = aws.dev
  instance_type = var.instance_type
  ami           = var.ami_id

  tags = merge(
    var.environment_tags,
    {
      Name = "dev-instance"
    }
  )
}

# EC2 Instance in Test Account
resource "aws_instance" "test" {
  provider      = aws.test
  instance_type = var.instance_type
  ami           = var.ami_id

  tags = merge(
    var.environment_tags,
    {
      Name = "test-instance"
    }
  )
}

