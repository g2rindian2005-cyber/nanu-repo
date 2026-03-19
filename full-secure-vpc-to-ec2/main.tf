resource "aws_vpc" "secure_vpc" {
  cidr_block = "10.0.0.0/16"

}

resource "aws_subnet" "public_subnet" {
vpc_id = aws_vpc.secure_vpc.id
cidr_block = "10.0.1.0/24"
  
}

resource "aws_subnet" "private_subnet" {
vpc_id = aws_vpc.secure_vpc.id
cidr_block ="10.0.2.0/24"  
}

resource "aws_internet_gateway" "igw" {
    vpc_id =aws_vpc.secure_vpc.id
  
}

resource "aws_route_table" "public_rt" {
 vpc_id = aws_vpc.secure_vpc.id
  
 route  {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
 }

} 

resource "aws_security_group" "secure_sg" {
    vpc_id = aws_vpc.secure_vpc.id
    

    ingress  {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["49.204.123.10/32"]
    }
            
    egress {
        from_port = 0
        to_port = 0
        protocol ="-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}  

resource "aws_key_pair" "key" {
  key_name   = "secure-key"
public_key = file("C:/Users/gokul/.ssh/id_rsa.pub")
}

resource "aws_iam_role" "ec2_role" {
  name = "ec2-secure-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
} 


resource "aws_iam_instance_profile" "profile" {
  name = "ec2-profile"
  role = aws_iam_role.ec2_role.name
}

resource "aws_instance" "secure_ec2" {
  ami           = "ami-02dfbd4ff395f2a1b" # update for your region
  instance_type = "t2.micro"

  subnet_id = aws_subnet.private_subnet.id

  vpc_security_group_ids = [aws_security_group.secure_sg.id]

  key_name = aws_key_pair.key.key_name

  iam_instance_profile = aws_iam_instance_profile.profile.name

  associate_public_ip_address = false  # 🔐 NO PUBLIC IP

  root_block_device {
    volume_size = 10
    volume_type = "gp3"
    encrypted   = true  # 🔐 encryption enabled
  }

  tags = {
    Name = "Secure-EC2"
  }
}