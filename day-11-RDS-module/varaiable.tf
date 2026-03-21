variable "region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
}

variable "subnets" {
  description = "Subnet configuration"
  type = map(object({
    cidr = string
    az   = string
  }))
}

variable "db_name" {
  description = "Initial database name"
  type        = string
}

variable "db_identifier" {
  description = "RDS instance identifier"
  type        = string
}

variable "db_engine" {
  type    = string
  default = "mysql"
}

variable "db_engine_version" {
  type    = string
  default = "8.0"
}

variable "db_instance_class" {
  type    = string
  default = "db.t3.micro"
}

variable "db_allocated_storage" {
  type    = number
  default = 20
}

variable "db_username" {
  type    = string
  default = "admin"
}

variable "backup_retention_period" {
  type    = number
  default = 1
}

variable "backup_window" {
  type    = string
  default = "07:00-09:00"
}

variable "maintenance_window" {
  type    = string
  default = "Sun:05:00-Sun:06:00"
}

variable "deletion_protection" {
  type    = bool
  default = true
}

variable "skip_final_snapshot" {
  description = "Skip final snapshot on delete"
  type        = bool
  default     = true
}

variable "bucket" {
  type = string
}
