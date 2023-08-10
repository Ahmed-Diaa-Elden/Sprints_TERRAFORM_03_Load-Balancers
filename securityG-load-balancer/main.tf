resource "aws_security_group" "terraform-securityG-Load-balancer" {
  name_prefix = "terraform-securityG"
  # vpc_id     = aws_vpc.vpc-terraform.id
  vpc_id     = var.vpc-terraform-id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.anyOne-cidr]
  }
  
  ingress {
    description = "Http from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.anyOne-cidr]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = [var.anyOne-cidr]
    # ipv6_cidr_blocks = ["::/0"]
  }
  
  tags = {
    Name = "terraform-securityG-Load-balancer"
  }
}

resource "aws_security_group" "terraform-securityG-private-Load-balancer" {
  name_prefix = "terraform-securityG-privateInstance"
  vpc_id     = var.vpc-terraform-id

  # For a private instance, you might want to allow incoming traffic only from the public subnet.

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = [var.vpc-terraform-cidr_block]
  }

  # Allow outgoing traffic to the internet through the NAT Gateway.

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.anyOne-cidr]
  }

  tags = {
    Name = "terraform-securityG-private-Load-balancer"
  }
}
