terraform {
  backend  "s3" { 
    bucket ="gokul-bucket-00"
    key = "newfolder/terraform.tfstate"
    region = "us-east-1"
  }





}