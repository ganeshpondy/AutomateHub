data "aws_ami" "latest-amazon-linux-image" {
    most_recent = true
    owners = ["amazon"]
    filter {
        name = "name"
        # values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-*-amd64-server-*"]
        values = [var.ami_name]
    }
    filter {
        name = "virtualization-type"
        values = ["hvm"]
    }
}

resource "aws_instance" "myapp-server" {
    ami = data.aws_ami.latest-amazon-linux-image.id
    instance_type = var.instance_type

    # vpc_zone_identifier = [var.pri_sub_3a_id,var.pri_sub_4b_id]
    subnet_id = var.pub_sub_1a_id
    vpc_security_group_ids = [var.webserver_sg_id]

    associate_public_ip_address = true
    key_name   = var.keypair_name

    user_data = file("${path.module}/install-patch.sh")

    tags = {
        Name = "${var.project_tag}-server"
    }
}