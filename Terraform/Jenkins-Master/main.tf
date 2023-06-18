provider "aws" {
  region = "ap-south-1"
}

// Define input variables
variable vpc_cidr_block {}              // CIDR block for the VPC
variable subnet_cidr_block {}           // CIDR block for the subnet
variable avail_zone {}                  // Availability zone for the subnet
variable env_prefix {}                  // Prefix to be used for naming resources
variable my_ip {}                       // IP address allowed for SSH access
variable instance_type {}               // EC2 instance type
variable ami_name {}                    // Name of the Amazon Machine Image (AMI)
variable public_key_location {}         // File location of the public key

// Create VPC resource
resource "aws_vpc" "myapp-vpc" {
  cidr_block = var.vpc_cidr_block

  tags = {
    Name = "${var.env_prefix}-vpc"
  }
}

// Create subnet resource
resource "aws_subnet" "myapp-subnet-1" {
  vpc_id            = aws_vpc.myapp-vpc.id
  cidr_block        = var.subnet_cidr_block
  availability_zone = var.avail_zone

  tags = {
    Name = "${var.env_prefix}-subnet-1"
  }
}

// Create internet gateway resource
resource "aws_internet_gateway" "myapp-igw" {
  vpc_id = aws_vpc.myapp-vpc.id

  tags = {
    Name = "${var.env_prefix}-igw"
  }
}

// Create default route table resource
resource "aws_default_route_table" "main-rtb" {
  default_route_table_id = aws_vpc.myapp-vpc.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.myapp-igw.id
  }

  tags = {
    Name = "${var.env_prefix}-main-rtb"
  }
}

// Create default security group resource
resource "aws_default_security_group" "default-sg" {
  vpc_id = aws_vpc.myapp-vpc.id

  // Ingress rules
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip]         // Allow SSH access only from the specified IP
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]      // Allow incoming traffic on port 8080 from any IP
  }

  // Egress rule
  egress {
    from_port         = 0
    to_port           = 0
    protocol          = "-1"
    cidr_blocks       = ["0.0.0.0/0"]   // Allow outgoing traffic to any IP
    prefix_list_ids   = []
  }

  tags = {
    Name = "${var.env_prefix}-default-sg"
  }
}

// Data source for retrieving the latest Amazon Linux AMI
data "aws_ami" "latest-amazon-linux-image" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = [var.ami_name]       // Specify the desired AMI name
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

// Create key pair resource for SSH access
resource "aws_key_pair" "ssh-key" {
  key_name   = "server-key"
  public_key = file(var.public_key_location)
}

// Create EC2 instance resource
resource "aws_instance" "myapp-server" {
  ami                         = data.aws_ami.latest-amazon-linux-image.id
  instance_type               = var.instance_type

  subnet_id                   = aws_subnet.myapp-subnet-1.id
  vpc_security_group_ids      = [aws_default_security_group.default-sg.id]
  availability_zone           = var.avail_zone

  associate_public_ip_address = true
  key_name                    = aws_key_pair.ssh-key.key_name

  user_data                   = file("installing-jenkins.sh")   // Script to install Jenkins

  tags = {
    Name = "${var.env_prefix}-server"
  }
}

// Output the AMI ID
output "aws_ami_id" {
  value = data.aws_ami.latest-amazon-linux-image.id
}

// Output the public IP of the EC2 instance
output "ec2_public_ip" {
  value = aws_instance.myapp-server.public_ip
}
