# VPC Module

module "sprints-vpc-1" {
  source = "./vpc"
  vpc-terraform-cidr_block = var.vpc-terraform-cidr_block
  subnet-terraform = var.subnet-terraform
  anyOne-cidr = var.anyOne-cidr
}

# -------------------------------------

# Instances and Provisioned-instances Module

module "terraform-instance-Public" {
  source = "./instances"
  ubuntu-instance = var.ubuntu-instance
  is_public_ip = true
  securityG_id = module.sprints-vpc-1.id_terraform-securityG
  id-subnet_terraform = module.sprints-vpc-1.id_public-1-subnet_terraform
  user_data_script = var.user_data_script
  # command = "echo ${module.terraform-instance-Public.Public-ip} >> ./private_ip.txt"
  # command = "echo Public-ip: ${module.terraform-instance-Public.Public-ip} >> ./all-ips.txt"
  instance_tag_name = "terraform-instance-Public"
}

module "terraform-instance-Provisioned" {
  source = "./provisioned-instances"
  ubuntu-instance = var.ubuntu-instance
  securityG_id = module.sprints-vpc-1.id_terraform-securityG
  id-subnet_terraform = module.sprints-vpc-1.id_public-2-subnet_terraform
  user_data_script = var.user_data_script
  ld_public_dns = module.Public-Load_balancer.dns-terraform-instance
  ### you should use the private dns of load balancer
  # ld_private_dns = module.terraform-instance-Private.Private-ip
  ld_private_dns = module.Private-Load_balancer.dns-terraform-instance
  # command = "echo Public-ip-2: ${module.terraform-instance-Provisioned.Public-ip} >> ./all-ips.txt"
  instance_tag_name = "terraform-instance-Provisioned"
}

module "terraform-instance-Private" {
  source = "./instances"
  ubuntu-instance = var.ubuntu-instance
  is_public_ip = false
  securityG_id = module.sprints-vpc-1.id_terraform-securityG-private
  id-subnet_terraform = module.sprints-vpc-1.id_private-1-subnet_terraform
  user_data_script = var.user_data_script_private
  # command = "echo Private-ip: ${module.terraform-instance-Private.Private-ip} >> ./all-ips.txt"
  instance_tag_name = "terraform-instance-Private"
}

module "terraform-instance-Private-2" {
  source = "./instances"
  ubuntu-instance = var.ubuntu-instance
  is_public_ip = false
  securityG_id = module.sprints-vpc-1.id_terraform-securityG-private
  id-subnet_terraform = module.sprints-vpc-1.id_private-2-subnet_terraform
  user_data_script = var.user_data_script_private
  # command = "echo Private-ip-2: ${module.terraform-instance-Private-2.Private-ip} >> ./all-ips.txt"
  instance_tag_name = "terraform-instance-Private-2"
}


# -------------------------------------

# Load Balancer SecurityG Module

module "security_groups" {
  source = "./securityG-load-balancer"
  vpc-terraform-cidr_block = var.vpc-terraform-cidr_block
  anyOne-cidr = var.anyOne-cidr
  vpc-terraform-id = module.sprints-vpc-1.vpc_id
}

# -------------------------------------

# Load Balancer Module

module "Public-Load_balancer" {
  source = "./load-balancer"
  internal = false
  securityG = module.security_groups.id_terraform-securityG
  subnets = [module.sprints-vpc-1.id_public-1-subnet_terraform, module.sprints-vpc-1.id_public-2-subnet_terraform]
  vpc-terraform-id = module.sprints-vpc-1.vpc_id
  target_instance_ids = [module.terraform-instance-Public.instance-id,  module.terraform-instance-Provisioned.instance-id]
  lb-TargetG-tag_name = "Public-TargetG"
  lb_tag_name = "Public-lb"
}

module "Private-Load_balancer" {
  source = "./load-balancer"
  internal = true
  securityG = module.security_groups.id_terraform-securityG-private
  subnets = [module.sprints-vpc-1.id_private-1-subnet_terraform, module.sprints-vpc-1.id_private-2-subnet_terraform]
  vpc-terraform-id = module.sprints-vpc-1.vpc_id
  target_instance_ids = [module.terraform-instance-Private.instance-id,  module.terraform-instance-Private-2.instance-id]
  lb-TargetG-tag_name = "Private-TargetG"
  lb_tag_name = "Private-lb"
}

# ----------------------------------------------------------------

# S3 Bucket Module

module "s3-bucket" {
  source = "./s3_bucket"
}

  # After running s3-bucket successfully uncomment the terraform backend

# terraform {
#   backend "s3" {
#     # Replace this with your bucket name
#     bucket = "sprints-state-terraform"
#     key    = "dev/terraform.tfstate"
#     region = "us-east-1"

#     # Replace this with your DynamoDB table name
#     dynamodb_table = "terraform-up-and-running-locks"
#     encrypt = true
#     profile        = "admin2-prog"
#   }
# }
