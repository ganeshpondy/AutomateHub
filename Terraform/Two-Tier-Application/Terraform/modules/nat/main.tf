# # NAT

# Allocate Elastic IP address each AZ's 
resource "aws_eip" "eip-nat-a" {
  domain   = "vpc"       #  Indicates if this EIP is for use in VPC

  tags   = {
    Name     = "${var.project_tag}_eip-nat-a"
    Project = var.project_tag
  }
}

resource "aws_eip" "eip-nat-b" {
  domain   = "vpc"

  tags   = {
    Name     = "${var.project_tag}_eip-nat-b"
    Project = var.project_tag
  }
}

# # Create NAT Gateway
resource "aws_nat_gateway" "nat-az1" {
  allocation_id = aws_eip.eip-nat-a.id
  subnet_id     = var.pub_sub_1a_id

  tags = {
    Name     = "${var.project_tag}_nat-az1"
    Project = var.project_tag
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [var.igw_name]
}

resource "aws_nat_gateway" "nat-az2" {
  allocation_id = aws_eip.eip-nat-b.id
  subnet_id     = var.pub_sub_2b_id

  tags = {
    Name     = "${var.project_tag}_nat-az2"
    Project = var.project_tag
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [var.igw_name]
}


# create private route table Pri-RT-A and add route through NAT-GW-A
resource "aws_route_table" "pri-rt-az1" {
  vpc_id            = var.vpc_id

  route {
    cidr_block      = "0.0.0.0/0"
    nat_gateway_id  = aws_nat_gateway.nat-az1.id
  }

  tags   = {
    Name     = "${var.project_tag}_pri-rt-az1"
    Project = var.project_tag
  }
}

# associate private subnet pri-sub-3-a with private route table Pri-RT-A
resource "aws_route_table_association" "pri-sub-3a-with-pri-rt-az1" {
  subnet_id         = var.pri_sub_3a_id
  route_table_id    = aws_route_table.pri-rt-az1.id
}


resource "aws_route_table" "pri-rt-az2" {
  vpc_id            = var.vpc_id

  route {
    cidr_block      = "0.0.0.0/0"
    nat_gateway_id  = aws_nat_gateway.nat-az2.id
  }

  tags   = {
    Name     = "${var.project_tag}_pri-rt-az2"
    Project = var.project_tag
  }
}

# associate private subnet pri-sub-4-b with private route table Pri-RT-A
resource "aws_route_table_association" "pri-sub-4b-with-pri-rt-az2" {
  subnet_id         = var.pri_sub_4b_id
  route_table_id    = aws_route_table.pri-rt-az2.id
}