resource "aws_vpc" "my-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "gokul-vpc"
  }
}

resource "aws_subnet" "public-subnet" {
  vpc_id            = aws_vpc.my-vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "public-subnet"
  }
  
}

resource "aws_subnet" "private-subnet" {
  vpc_id    = aws_vpc.my-vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name ="private-subnet"
  }
} 

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.my-vpc.id
    tags = {
        Name ="gokul-igw"
    } 

  
} 
resource "aws_eip" "nat-eip" {
    domain = "vpc"
  
}
resource "aws_nat_gateway" "nat" {
    allocation_id = aws_eip.nat-eip.id
    subnet_id     = aws_subnet.public-subnet.id
    tags = {
        Name = "gokul-nat-gateway"
    } 

  
} 
resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.my-vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
} 
resource "aws_route_table_association" "rt-assosiation" {
    subnet_id = aws_subnet.public-subnet.id
    route_table_id = aws_route_table.public-route-table.id
  
}
resource "aws_route_table" "private-route-table" {
    vpc_id = aws_vpc.my-vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_nat_gateway.nat.id
    }
} 
resource "aws_route_table_association" "private-rt-association" {
    subnet_id = aws_subnet.private-subnet.id
    route_table_id = aws_route_table.private-route-table.id
  
} 

resource "aws_security_group" "sg" {
    name = "gokul-sg"
    description = "Allow SSH and HTTP"
    vpc_id = aws_vpc.my-vpc.id

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 80
        to_port= 80
        protocol = "http"
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
} 

resource "aws_instance" "my-ec2" {
  ami = "ami-02dfbd4ff395f2a1b"
   instance_type = "t2.micro"
   tags = {
     Name = "gokul-ec2"
   }
}