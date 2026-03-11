variable "region" {
  description = "AWS region for all accounts"
  type        = string
  default     = "us-east-1"
}

variable "dev_account_id" {
  description = "Dev AWS Account ID"
  type        = string
}

variable "test_account_id" {
  description = "Test AWS Account ID"
  type        = string
}

variable "assume_role_name" {
  description = "IAM Role name to assume in target accounts"
  type        = string
  default     = "TerraformRole"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "ami_id" {
  description = "AMI ID for EC2 instances"
  type        = string
  default     = "ami-02dfbd4ff395f2a1b"

}

variable "environment_tags" {
  description = "Common tags for resources"
  type        = map(string)
}
