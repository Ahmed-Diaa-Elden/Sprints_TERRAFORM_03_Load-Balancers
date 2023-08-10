# The First periority for --var
# Second values.auto.tfvars
# Third terraform.tfvars

vpc-terraform-cidr_block = "10.0.0.0/16"
anyOne-cidr = "0.0.0.0/0"
ubuntu-instance = ["t2.micro", "Sprints-Key-pair"]
user_data_script = <<-EOF
    #!/bin/bash
    sudo apt-get update -y
    sudo apt-get install nginx -y
    sudo systemctl start nginx
    sudo systemctl enable nginx
  EOF

user_data_script_private =  <<-EOF
    #!/bin/bash
    sudo apt-get update -y
    sudo apt-get install -y apache2
    sudo systemctl start apache2
    sudo systemctl enable apache2
  EOF

subnet-terraform = {
  "public-subnet-terraform" = ["10.0.0.0/24","us-east-1a"],
  "public-2-subnet-terraform" = ["10.0.2.0/24","us-east-1b"],
  "private-subnet-terraform" = ["10.0.1.0/24","us-east-1c"],
  "private-2-subnet-terraform" = ["10.0.3.0/24","us-east-1d"],
}

