# Create a VPC
resource "aws_vpc" "vpc" {
  cidr_block = var.cidr_range
  instance_tenancy        = "default"
  enable_dns_hostnames    = true
  enable_dns_support =  true

  tags = {
    Project = var.project_tag
    Name = "${var.project_tag}_vpc"
  }
}


#  create a VPC Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Project = var.project_tag
    Name = "${var.project_tag}_igw"
  }
}

# use data source to get all avalablility zones in region
data "aws_availability_zones" "available_zones" {}

# create public subnet pub_sub_1a
resource "aws_subnet" "pub_sub_1a" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.pub_sub_1a_cidr
  availability_zone       = data.aws_availability_zones.available_zones.names[0]
  map_public_ip_on_launch = true

  tags      = {
    Name    = "pub_sub_1a"
    Project = var.project_tag
  }
}

# create public subnet pub_sub_2b
resource "aws_subnet" "pub_sub_2b" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.pub_sub_2b_cidr
  availability_zone       = data.aws_availability_zones.available_zones.names[1]
  map_public_ip_on_launch = true

  tags      = {
    Name    = "pub_sub_2b"
    Project = var.project_tag
  }
}

# create private subnet pri_sub_3a
resource "aws_subnet" "pri_sub_3a" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.pri_sub_3a_cidr
  availability_zone       = data.aws_availability_zones.available_zones.names[0]
  map_public_ip_on_launch = false           # instances that you launch into this subnet won't be assigned a public IP address by default

  tags      = {
    Name    = "pri_sub_3a"
    Project = var.project_tag
  }
}

# create private subnet pri_sub_4b
resource "aws_subnet" "pri_sub_4b" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.pri_sub_4b_cidr
  availability_zone       = data.aws_availability_zones.available_zones.names[1]
  map_public_ip_on_launch = false

  tags      = {
    Name    = "pri_sub_4b"
    Project = var.project_tag
  }
}

# create private subnet pri_sub_5a
resource "aws_subnet" "pri_sub_5a" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.pri_sub_5a_cidr
  availability_zone       = data.aws_availability_zones.available_zones.names[0]
  map_public_ip_on_launch = false

  tags      = {
    Name    = "pri_sub_5a"
    Project = var.project_tag
  }
}

# create private subnet pri_sub_6b
resource "aws_subnet" "pri_sub_6b" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.pri_sub_6b_cidr
  availability_zone       = data.aws_availability_zones.available_zones.names[1]
  map_public_ip_on_launch = false

  tags      = {
    Name    = "pri_sub_6b"
    Project = var.project_tag
  }
}

# create route table and add public route
resource "aws_route_table" "public_route_table" {
  vpc_id       = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags       = {
    Name     = "${var.project_tag}_route_table"
    Project = var.project_tag
  }
}


# associate public subnet pub-sub-1a to public route table
resource "aws_route_table_association" "pub-sub-1a_route_table_association" {
  subnet_id           = aws_subnet.pub_sub_1a.id
  route_table_id      = aws_route_table.public_route_table.id
}

# associate public subnet  pub-sub-2b to "public route table"
resource "aws_route_table_association" "pub-sub-2-b_route_table_association" {
  subnet_id           = aws_subnet.pub_sub_2b.id
  route_table_id      = aws_route_table.public_route_table.id
}

####################################################################################
