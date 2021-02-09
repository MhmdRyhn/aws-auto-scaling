resource "aws_cloudwatch_metric_alarm" "request_count_per_target_up_alarm" {
  alarm_name        = "${local.resource_name_prefix}-request-count-per-target-alarm"
  alarm_description = "Scale out alarm when the number-of-request-count >= threshold"
  namespace         = "AWS/ApplicationELB"
  dimensions = {
    TargetGroup = aws_lb_target_group.primary_alb_target_group.name
  }
  metric_name         = "RequestCountPerTarget"
  statistic           = "Sum"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  threshold           = var.request_per_server_per_minute
  period              = 60 # Seconds
  evaluation_periods  = 1
  alarm_actions       = [aws_autoscaling_policy.scale_out_policy.arn]
}
