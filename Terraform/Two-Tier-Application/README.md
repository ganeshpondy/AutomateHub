
Steps:


VPC :
01: Create VPC
02: Create & Attach Internget Gateway
03: 2 Public Subnet => Done
04: 2 Private Subnet for web Server
05: 2 Private Subnet (2-DB)
06: Create Route Table
07: Associate the Route Table with Public Subnets

NAT :
08: Create 2 elastic ip, one for each AZ's
09: Create 2 NAT Gateway, one for each AZ's
10: Create 2 private route table and add route through each AZ's
11: Association with route_table and Private subnet 3a & 4b (web tier)

Security-Group :
12: Create SG Rule for Application LoadBalancer, Web Server & Database

Application LoadBalancer:
13: Create LoadBalancer with Type 'Application'
14: Create Target Group
15: Create Listener (on Port)

KeyPair :
16: Create KeyPair

AutoScale-Group :
17: Add keypair
18: Create Launch Template
19: Create AutoScaling Group
20: scale_up & scale_down Policies
21: scale_up & scale_down Alerms 

RDS :
22: Security group for RDS
23: Create RDS Instance

CloudFront :
24: Get the certificate from AWS ACM
    ganeshpondy.link
25: CloudFront Access Control for S3 Website

route53 :
26: Create Record

27: .gitignore

Module :
01: VPC
02: NAT
03: Security-Group
06: SSHKey (Public & Private Keys)
04: AutoScale-Group
03: ALB
07: RDS (MySQL)
05: CloudFront
08: Route53


![Diagram](https://github.com/ganeshpondy/AutomateHub/assets/18094905/373b73ef-52de-410a-abce-b4968c4701fc)

