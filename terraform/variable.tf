variable "aws_profile" {
  type        = string
  description = "Name of the profile stored in ~/.aws/credentials file."
}

variable "aws_region" {
  type        = string
  description = "Name of the aws region."
  default     = "ap-southeast-1" // Singapore
}

variable "prefix" {
  type        = string
  description = "A prefix that is to be used with the resource name. Usually, this should be the application name."
}

variable "service" {
  type        = string
  description = "Name of the service. E.g., auth, payment, reporting etc."
  default     = ""
}

variable "environment" {
  type        = string
  description = "Environment name, e.g., Dev, Test, Stage, UAT, Prod etc."
}

variable "image_id" {
  type        = string
  description = "AWS AMI ID. Install all the required software packages when building the Image."
}

variable "instance_type" {
  type        = string
  description = "Type of EC2 instance."
  default     = "t2.micro"
}

variable "vpc_id" {
  type        = string
  description = "VPC id where the application is to be deployed."
}

variable "spot_instance_max_price" {
  type        = string
  description = "Maximum price for the spot instances."
  default     = "0.005"
}

variable "key_pair_name" {
  type        = string
  description = "Name of the key pair that will be used to login to the EC2 instance(s)."
}

variable "associate_public_ip_address" {
  type        = bool
  description = "Whether to associate a public ip to each EC2 instance launced."
  default     = true
}

variable "enable_monitoring" {
  type        = bool
  description = "Whether to enable EC2 instance detailed monitoring with CloudWatch."
  default     = true
}

variable "vpc_zone_identifier" {
  type        = list(string)
  description = "A list of subnets ids where to launch ec2 instances."
}


variable "request_per_server" {
  type        = number
  description = "Number of request a server can handle per Unit Time per Datapoint (in CloudWatch metric)."
  default     = 100
}


variable "period" {
  # evaluation interval = datapoints * period
  #
  # >> period, datapoints/evaluation periods, datapoints_to_alarm can be different for scale out and scale in policies.
  type        = number
  description = "Length of time (in seconds) to evaluate the metric to create each individual data point."
  default     = 60 // 60 Seconds
}


variable "datapoints" {
  # Also known as `Evaluation Periods`
  # evaluation interval = datapoints * period
  #
  # >> period, datapoints/evaluation periods, datapoints_to_alarm can be different for scale out and scale in policies.
  type        = number
  description = "Number of the most recent data points within metric evaluation period when determining alarm state."
  default     = 1
}


variable "datapoints_to_alarm" {
  # This MUST be less than or equal to the `datapoints`. Otherwise, the alarm will never go into ALARM state.
  #
  # Let, datapoints_to_alarm = M, datapoints = N, period = P.
  # If I configure M out of N datapoints with a period of P, then if M datapoints breaches the threshold
  # within the evaluation inerval (N * P), then the alarm goes into ALARM state.
  #
  # >> period, datapoints/evaluation periods, datapoints_to_alarm can be different for scale out and scale in policies.
  type        = string
  description = "The number of data points within the Evaluation Periods that must be breaching to cause the alarm to go to the ALARM state."
}


variable "asg_cooldown_period" {
  # The amount of time (in seconds) after a scaling activity completes before another scaling activity can start.
  type        = number
  description = "Time (in seconds) after which a scaling takes place."
  default     = 10 // 10 seconds
}


variable "health_check_interval" {
  type        = number
  description = "Interval (in seconds) after which health check request is sent by ALB."
  default     = 30 // 30 Seconds
}


variable "alb_health_check_path" {
  type        = string
  description = "Path of the health check url."
  default     = "/health-check"
}
