data "aws_vpc" "app_vpc" {
  id = var.vpc_id
}

// TODO: Need to create a security group for the ALB.

resource "aws_security_group" "app_instance_sg" {
  name        = "${local.resource_name_prefix}-security-group"
  description = "Allow HTTP traffic from VPC"
  vpc_id      = var.vpc_id

  ingress {
    description = "HTTP from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    // TODO: This needs to be optimized.
    // This should be from the subnet(s) where the Load Balancer exists.
    // Or it can be from the security group assigned to the load balancer.
    cidr_blocks = [data.aws_vpc.app_vpc.cidr_block]
  }

  egress {
    description      = "Anywhere to the world"
    from_port        = 0
    to_port          = 0
    protocol         = -1
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = local.common_tags
}
