terraform {
  backend "s3" { 
    bucket = "rathod-gokul01"
    key    = "jawan-folder/terraform.tf"
    region = "us-east-1"
    dynamodb_table = "terraform-state-lock"
  }
}