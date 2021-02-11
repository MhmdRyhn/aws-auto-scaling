// TODO: Need to convert all the hardcoded values into `variable` or `local`.

resource "aws_lb" "primary_alb" {
  name               = "${local.resource_name_prefix}-primary-alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = var.vpc_zone_identifier
}


resource "aws_lb_listener" "primary_alb_listener" {
  load_balancer_arn = aws_lb.primary_alb.arn
  protocol          = local.http.protocol
  port              = local.http.port
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
  protocol    = local.http.protocol
  port        = local.http.port
  //  slow_start  = 10
  stickiness {
    type    = "lb_cookie"
    enabled = false
  }
  health_check {
    enabled  = true
    interval = var.health_check_interval
    path     = var.alb_health_check_path
    protocol = local.http.protocol
    port     = local.http.port
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

    // # 'forward' block must have at least two "target_group" block inside it
    //    forward {
    //      target_group {
    //        arn = aws_lb_target_group.primary_alb_target_group.arn
    //        weight = 1
    //      }
    //      stickiness {
    //        enabled = false
    //        duration = 1
    //      }
    //    }
  }
  condition {
    path_pattern {
      values = ["/*"]
    }
  }
}
