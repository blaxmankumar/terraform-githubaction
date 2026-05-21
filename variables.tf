variable "region" {
  description = "AWS Region"
  type        = string
}

variable "vpc_cidr" {
  description = "VPC CIDR Block"
  type        = string
}

variable "subnet_cidr" {
  description = "Subnet CIDR Block"
  type        = string
}

variable "instance_type" {
  description = "EC2 Instance Type"
  type        = string
}

variable "ami_id" {
  description = "Ubuntu AMI"
  type        = string
}

variable "bucket_name" {
  description = "S3 Bucket Name"
  type        = string
}