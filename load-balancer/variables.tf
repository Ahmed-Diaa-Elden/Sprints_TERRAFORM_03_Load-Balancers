# variable "instance_tag_name" {
#   type = string
#   default = "terraform-instance"
# }

variable "internal" {
  type = bool
  default = false
}

variable "securityG" {
  type = string
}

variable "subnets" {
  type = list
  default = ["subnet-0f81942240b28838d", "subnet-0f86dc2e7072579fe"]
}

variable "vpc-terraform-id" {
  type = string
}

variable "target_instance_ids" {
  type = list
}

variable "lb-TargetG-tag_name" {
  type = string
  default = "terraform-lb"
}

variable "lb_tag_name" {
  type = string
  default = "terraform-targetG"
}

