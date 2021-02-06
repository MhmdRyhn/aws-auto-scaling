resource "aws_lb" "primary_alb" {
  name               = "${local.resource_name_prefix}-primary-load-balancer"
  internal           = false
  load_balancer_type = "application"
  subnets            = []
}


resource "aws_lb_listener" "primary_alb_listener" {
  load_balancer_arn = aws_lb.primary_alb.arn
  protocol          = "HTTP"
  port              = 80
  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "Test Response For ALB Listener"
      status_code  = "200"
    }
  }
}


resource "aws_lb_target_group" "primary_alb_target_group" {
  name        = "${local.resource_name_prefix}-target-group"
  vpc_id      = var.vpc_id
  target_type = "instance"
  protocol    = "HTTP"
  port        = 80
//  slow_start  = 10
  stickiness {
    type    = "lb_cookie"
    enabled = false
  }
  health_check {
    enabled  = true
    interval = 30
    path     = "/health-check"
    protocol = "HTTP"
    port     = 80
    timeout  = 5 # Seconds
    matcher  = "200"
  }
}


resource "aws_lb_listener_rule" "primary_alb_listener_rule" {
  listener_arn = aws_lb_listener.primary_alb_listener.arn
  priority     = 1
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.primary_alb_target_group.arn
  }
  condition {
    path_pattern {
      values = ["/*"]
    }
  }
}
