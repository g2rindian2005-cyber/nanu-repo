region             = "us-east-1"
dev_account_id     = "123456789012"  # Replace with your Dev Account ID
test_account_id    = "210987654321"  # Replace with your Test Account ID
assume_role_name   = "TerraformRole"
instance_type      = "t3.micro"
ami_id             = "ami-02dfbd4ff395f2a1b"

environment_tags = {
  Environment = "dev"
  Project     = "multi-account"
  Terraform   = "true"
}
