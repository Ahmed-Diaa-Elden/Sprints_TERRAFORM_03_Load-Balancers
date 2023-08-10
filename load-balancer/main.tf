resource "aws_lb" "Terraform_lb" {
  # name               = "Terraform_lb"
  name               = var.lb_tag_name
  internal           = var.internal
  load_balancer_type = "application"
  security_groups    = [var.securityG]
  subnets            = var.subnets  # Replace with your desired subnets either public or private ones
    tags = {
    Name = var.lb_tag_name
  }

}

resource "aws_lb_target_group" "Terraform_targetG" {
  # name     = "Terraform-TargetG"
  name     = var.lb-TargetG-tag_name
  port     = "80"
  protocol = "HTTP"
  vpc_id   = var.vpc-terraform-id  # Replace with your VPC ID
      tags = {
    Name = var.lb-TargetG-tag_name
  }

}

resource "aws_lb_listener" "Terraform_listener" {
  load_balancer_arn = aws_lb.Terraform_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.Terraform_targetG.arn
  }
}

resource "aws_lb_target_group_attachment" "Terraform_attachment" {
  target_group_arn = aws_lb_target_group.Terraform_targetG.arn
  # target_id        = aws_instance.nginx_instance.id
  count            = length(var.target_instance_ids)
  # for_each         = var.target_instance_ids
  target_id        = var.target_instance_ids[count.index]
  port             = 80
}
