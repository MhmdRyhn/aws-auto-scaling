resource "aws_cloudwatch_metric_alarm" "request_count_per_target_scale_out_alarm" {
  alarm_name        = "${local.resource_name_prefix}-scale-out-alarm"
  alarm_description = "Scale out alarm when the number-of-request-count >= threshold"
  namespace         = "AWS/ApplicationELB"
  dimensions = {
    TargetGroup = aws_lb_target_group.primary_alb_target_group.arn_suffix
  }
  metric_name         = "RequestCountPerTarget"
  statistic           = "Sum"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  threshold           = var.request_per_server
  period              = var.period
  evaluation_periods  = var.datapoints
  datapoints_to_alarm = var.datapoints_to_alarm
  alarm_actions       = [aws_autoscaling_policy.scale_out_policy.arn]
}


resource "aws_cloudwatch_metric_alarm" "request_count_per_target_scale_in_alarm" {
  alarm_name        = "${local.resource_name_prefix}-scale-in-alarm"
  alarm_description = "Scale out alarm when the number-of-request-count < threshold"
  namespace         = "AWS/ApplicationELB"
  dimensions = {
    TargetGroup = aws_lb_target_group.primary_alb_target_group.arn_suffix
  }
  metric_name         = "RequestCountPerTarget"
  statistic           = "Sum"
  comparison_operator = "LessThanOrEqualToThreshold"
  threshold           = var.request_per_server
  period              = var.period
  evaluation_periods  = var.datapoints
  datapoints_to_alarm = var.datapoints_to_alarm
  alarm_actions       = [aws_autoscaling_policy.scale_in_policy.arn]
}
