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

variable "environment" {
  type        = string
  description = "Environment name, e.g., Dev, Test, Stage, UAT, Prod etc."
}

variable "image_id" {
  type        = string
  description = "AWS AMI ID."
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


variable "request_per_server_per_minute" {
  type        = string
  description = "Number of request served per instance per minute."
}
