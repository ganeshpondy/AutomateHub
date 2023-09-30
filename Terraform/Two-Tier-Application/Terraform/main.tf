terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.16.2"
    }
  }
}

module "vpc" {
  source          = "./modules/vpc"
  project_tag     = var.project_tag
  cidr_range      = var.cidr_range
  pub_sub_1a_cidr = var.pub_sub_1a_cidr
  pub_sub_2b_cidr = var.pub_sub_2b_cidr
  pri_sub_3a_cidr = var.pri_sub_3a_cidr
  pri_sub_4b_cidr = var.pri_sub_4b_cidr
  pri_sub_5a_cidr = var.pri_sub_5a_cidr
  pri_sub_6b_cidr = var.pri_sub_6b_cidr
}

module "nat" {
  source        = "./modules/nat"
  project_tag   = var.project_tag
  vpc_id        = module.vpc.vpc_id
  igw_name      = module.vpc.igw_name
  pub_sub_1a_id = module.vpc.pub_sub_1a_id
  pub_sub_2b_id = module.vpc.pub_sub_2b_id
  pri_sub_3a_id = module.vpc.pri_sub_3a_id
  pri_sub_4b_id = module.vpc.pri_sub_4b_id
}

module "security-group" {
  source      = "./modules/security-group"
  project_tag = var.project_tag
  vpc_id      = module.vpc.vpc_id
  cidr_range  = var.cidr_range
}

module "key-pair" {
  source              = "./modules/key-pair"
  public_key_location = var.public_key_location
}

# module "ec2" {
#   source          = "./modules/ec2"
#   instance_type   = var.instance_type
#   project_tag     = var.project_tag
#   ami_name        = var.ami_name
#   pub_sub_1a_id   = module.vpc.pub_sub_1a_id
#   pri_sub_4b_id   = module.vpc.pri_sub_4b_id
#   webserver_sg_id = module.security-group.webserver_sg_id
#   keypair_name    = module.key-pair.keypair_name

# }

module "lt-asg" {
  source = "./modules/lt-asg"
  # ami_image_id  = module.ec2.ami_image_id
  ami_image_id           = var.ami_image_id
  instance_type          = var.instance_type
  vpc_security_group_ids = module.security-group.webserver_sg_id
  project_tag            = var.project_tag
  pub_sub_1a_id          = module.vpc.pub_sub_1a_id
  pub_sub_2b_id          = module.vpc.pub_sub_2b_id
  alb_target_group_arn   = module.alb.alb_target_group_arn
}

module "alb" {
  source          = "./modules/alb"
  project_tag     = var.project_tag
  vpc_id          = module.vpc.vpc_id
  webserver_sg_id = module.security-group.webserver_sg_id
  pub_sub_1a_id   = module.vpc.pub_sub_1a_id
  pub_sub_2b_id   = module.vpc.pub_sub_2b_id
}

module "route53" {
  source       = "./modules/route53"
  route53_zone_name = var.route53_zone_name
  route53_record_name = var.route53_record_name
  alb_dns_name = module.alb.alb_dns_name
  alb_zone_id  = module.alb.alb_zone_id
  cloudfront_domain_name = module.cloudfront.cloudfront_domain_name
  cloudfront_hosted_zone_id = module.cloudfront.cloudfront_hosted_zone_id
}

module "cloudfront" {
  source       = "./modules/cloudfront"
  alb_dns_name = module.alb.alb_dns_name
  project_tag     = var.project_tag
  route53_record_name = var.route53_record_name

}