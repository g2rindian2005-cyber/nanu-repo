# Multi-Account Terraform Setup

This configuration deploys the same resources to both **Dev** and **Test** AWS accounts.

## Prerequisites

1. **AWS Accounts**: You need two AWS accounts (Dev and Test)
2. **IAM Role**: Create a role named `TerraformRole` in both accounts with appropriate permissions
3. **Cross-Account Trust**: Configure the trust relationship to allow your primary account to assume the role

## Setup Steps

### 1. Create IAM Role in Both Accounts

In each AWS account (Dev & Test), create an IAM role:

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::YOUR_PRIMARY_ACCOUNT:root"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
```

### 2. Update Variables

Edit **dev.tfvars** and **test.tfvars**:

```hcl
dev_account_id     = "123456789012"  # Your actual Dev Account ID
test_account_id    = "210987654321"  # Your actual Test Account ID
region             = "us-east-1"     # Change if needed
```

### 3. Configure AWS Credentials

Set your AWS credentials in your primary account:

```bash
export AWS_ACCESS_KEY_ID=your_key
export AWS_SECRET_ACCESS_KEY=your_secret
```

### 4. Deploy

Initialize Terraform:
```bash
terraform init
```

Plan deployment:
```bash
terraform plan -var-file="dev.tfvars"
```

Apply changes:
```bash
terraform apply -var-file="dev.tfvars"
```

## File Structure

- **provider.tf** - Multi-account provider configuration with aliases
- **variables.tf** - Variable definitions
- **main.tf** - Resource definitions (created in both accounts)
- **outputs.tf** - Output values from both accounts
- **dev.tfvars** - Dev account variables
- **test.tfvars** - Test account variables

## Resources Created

- EC2 instance in Dev account (aws_instance.dev)
- EC2 instance in Test account (aws_instance.test)

Both instances are created in the same region using the same AMI and instance type.

## Customization

To add more resources, add them to your resource blocks and include the `provider` argument with the appropriate alias (`aws.dev` or `aws.test`).

Example:
```hcl
resource "aws_s3_bucket" "dev_bucket" {
  provider = aws.dev
  # ... configuration
}

resource "aws_s3_bucket" "test_bucket" {
  provider = aws.test
  # ... configuration
}
```
