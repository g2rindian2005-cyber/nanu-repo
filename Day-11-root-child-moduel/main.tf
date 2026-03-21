module "vpc" {
  source = "./moduls/vpc"

  vpc_cidr          = var.vpc_cidr
  availability_zone = var.az
  subnet_cidr       = var.subnet_cidr   # ✅ ADD THIS
}
module "ec2" {
  source = "./moduls/Ec2"

  ami_id      = var.ami          # ✅ match module variable
  instance_id = var.instance_type  # ⚠️ only if module expects this name

}
# s3 bucket
module "s3" {
  source = "./moduls/vpc/s3"
   bucket_name = var.bucket_name
   environment = var.environment

}