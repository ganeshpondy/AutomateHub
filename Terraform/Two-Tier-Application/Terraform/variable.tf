

variable "region" {}

variable "cidr_range" {
  type        = string
  description = "cidr range for the project"
}

variable "project_tag" {
  type        = string
  description = "Project Name & Tab for all resources"
}

# VPC
variable "pub_sub_1a_cidr" {}
variable "pub_sub_2b_cidr" {}
variable "pri_sub_3a_cidr" {}
variable "pri_sub_4b_cidr" {}
variable "pri_sub_5a_cidr" {}
variable "pri_sub_6b_cidr" {}

# autoscale-group
variable "ami_id" {}
variable "instance_type" {}
variable "max_size" {}
variable "min_size" {}
variable "desired_cap" {}
variable "asg_health_check_type" {}

# RDS
variable "rds_name" {}
variable "db_username" {}
variable "db_password" {}

# CloudFront
variable "certificate_domain_name" {}
variable "additional_domain_name" {}

# Route53
variable "route53_zone_name" {}

variable "route53_record_name" {}


# EC2
variable "ami_name" {}

# KeyPair
variable "public_key_location" {}

# Launch Template
variable "ami_image_id" {}

