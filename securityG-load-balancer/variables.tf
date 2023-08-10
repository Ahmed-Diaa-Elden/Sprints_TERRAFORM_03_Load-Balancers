# variable "cidr" {
#   type = string
#   default = "10.0.0.0/24"
# }

variable "vpc-terraform-cidr_block" {
  description = "refer to vpc CIDR"
  type = string
  default = "10.0.0.0/16"
}
# ----------------------------

variable "anyOne-cidr" {
  type = string
  default = "0.0.0.0/0"
}

# ------------------

variable "vpc-terraform-id" {
  type = string
}

# ------------------

