resource "aws_launch_configuration" "launch_configuration" {
  name                        = "${local.resource_name_prefix}-launch-config"
  image_id                    = var.image_id
  instance_type               = var.instance_type
  key_name                    = var.key_pair_name
  iam_instance_profile        = aws_iam_instance_profile.ec2_instance_profile.name
  spot_price                  = var.spot_instance_max_price
  security_groups             = [aws_security_group.app_instance_sg.id]
  associate_public_ip_address = var.associate_public_ip_address
  enable_monitoring           = var.enable_monitoring
  user_data                   = data.template_file.user_data.rendered
  root_block_device {
    delete_on_termination = true
  }
}


resource "aws_autoscaling_group" "auto_scaling_group" {
  name                 = "${local.resource_name_prefix}-auto-scaling-group"
  launch_configuration = aws_launch_configuration.launch_configuration.name
  vpc_zone_identifier  = var.vpc_zone_identifier
  max_size             = 5
  min_size             = 1
  desired_capacity     = 1
  # TODO: Need to add more attribite. It's not incomplete for now.
  health_check_type = "EC2"
  enabled_metrics = local.enabled_metrics
}


resource "aws_autoscaling_attachment" "autoscaling_target_group_attachment" {
  autoscaling_group_name = aws_autoscaling_group.auto_scaling_group.name
  alb_target_group_arn   = aws_lb_target_group.primary_alb_target_group.arn
}


resource "aws_autoscaling_policy" "scale_out_policy" {
  name                    = "${local.resource_name_prefix}-scale-out-policy"
  autoscaling_group_name  = aws_autoscaling_group.auto_scaling_group.name
  adjustment_type         = "ExactCapacity"
  policy_type             = "StepScaling"
  metric_aggregation_type = "Average"
  step_adjustment {
    scaling_adjustment          = 1
    metric_interval_lower_bound = 0
    metric_interval_upper_bound = var.request_per_server_per_minute
  }
  step_adjustment {
    scaling_adjustment          = 2
    metric_interval_lower_bound = var.request_per_server_per_minute
    metric_interval_upper_bound = var.request_per_server_per_minute * 2
  }
  step_adjustment {
    scaling_adjustment          = 3
    metric_interval_lower_bound = var.request_per_server_per_minute * 2
    metric_interval_upper_bound = var.request_per_server_per_minute * 3
  }
  step_adjustment {
    scaling_adjustment          = 4
    metric_interval_lower_bound = var.request_per_server_per_minute * 3
    metric_interval_upper_bound = var.request_per_server_per_minute * 4
  }
  step_adjustment {
    scaling_adjustment          = 5
    metric_interval_lower_bound = var.request_per_server_per_minute * 4
  }
}
