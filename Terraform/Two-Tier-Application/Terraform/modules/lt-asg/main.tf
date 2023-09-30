resource "aws_launch_template" "lt_name" {
  name = "project_LT"
  image_id = var.ami_image_id
  instance_type = var.instance_type
  vpc_security_group_ids = [var.vpc_security_group_ids]

  tag_specifications {
    resource_type = "instance"
    tags = {
        Name = "${var.project_tag}-server"
    }
  }

  # user_data = filebase64("${path.module}/install-patch-base64.sh")
}

resource "aws_autoscaling_group" "asg_name" {
  name               = "${var.project_tag}-asg"
  vpc_zone_identifier       = [var.pub_sub_1a_id, var.pub_sub_2b_id]
  health_check_grace_period = 20
  health_check_type         = "EC2" #"ELB" or default EC2
  min_size           = 1
  desired_capacity   = 2
  max_size           = 2
  target_group_arns   = [var.alb_target_group_arn]  # It will add EC2 Instances into Target Groups
  launch_template {
    id      = aws_launch_template.lt_name.id
    version = "$Latest"
  }
  timeouts {
    delete = "10m"
  }

}
