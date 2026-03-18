module "instance" {
   source = "../day-10-module-2"
   ami_id = "ami-02dfbd4ff395f2a1b"
   instance_type = "t3.micro"
}  

module "ec2" {
   source = "../day-10-module-2"
   ami_id = "ami-02dfbd4ff395f2a1b"
   instance_type = "t3.small"
  
}



