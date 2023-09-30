
# create target group
resource "aws_lb_target_group" "alb_target_group" {
  name        = "${var.project_tag}-tg"
  target_type = "instance"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id

  health_check {
    enabled             = true
    interval            = 10
    path                = "/"
    timeout             = 9
    matcher             = 200
    healthy_threshold   = 2
    unhealthy_threshold = 3
  }

  lifecycle {
    create_before_destroy = true
  }
}


# Create LoadBalancer
resource "aws_lb" "alb" {
  name               = "${var.project_tag}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.webserver_sg_id]
  subnets            = [var.pub_sub_1a_id,var.pub_sub_2b_id]

  enable_deletion_protection = false

  # access_logs {
  #   bucket  = "balavg-terraform-backend"
  #   prefix  = "ALB_Logs"
  #   enabled = true
  # }

  tags = {
    Name = "${var.project_tag}-alb"
    Project = var.project_tag
  }
}

# create a listener on port 80 with redirect action
resource "aws_lb_listener" "alb_http_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.alb_target_group.arn
  }
}