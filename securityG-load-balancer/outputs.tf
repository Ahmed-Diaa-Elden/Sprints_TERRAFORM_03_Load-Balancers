# output "id_output" {
#   value = aws_vpc.test.id
# }

output "id_terraform-securityG" {
  value = aws_security_group.terraform-securityG-Load-balancer.id
}

output "id_terraform-securityG-private" {
  value = aws_security_group.terraform-securityG-private-Load-balancer.id
}

