region      = "ap-south-1"
project_tag = "project1"

cidr_range      = "172.0.0.0/16"
pub_sub_1a_cidr = "172.0.10.0/24"
pub_sub_2b_cidr = "172.0.20.0/24"
pri_sub_3a_cidr = "172.0.30.0/24"
pri_sub_4b_cidr = "172.0.40.0/24"
pri_sub_5a_cidr = "172.0.50.0/24"
pri_sub_6b_cidr = "172.0.60.0/24"

# AutoScale-Group
ami_id        = "ami-05552d2dcf89c9b24"
instance_type = "t2.micro"
# keypair_name          = ""
max_size              = "2"
min_size              = "1"
desired_cap           = "1"
asg_health_check_type = "ELB" #"ELB" or default EC2

# RDS
rds_name    = "week3rds"
db_username = "admin"
db_password = "Week3Pjt098"

# CloudFront
certificate_domain_name = "ganeshpondy.link"
additional_domain_name  = "book.ganeshpondy.link"

# Route53
route53_zone_name = "ganeshpondy.link"
route53_record_name = "terraform.ganeshpondy.link"


# EC2
ami_name = "ubuntu/images/hvm-ssd/ubuntu-jammy-*-amd64-server-*"

# KeyPair
public_key_location = "/home/balavg/.ssh/id_rsa.pub"

# Launch Template
ami_image_id = "ami-0559d62c7f7b4dbdd"