provider "aws" {
  region = "us-east-1"
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}



# terraform { 
#   cloud { 
    
#     organization = "gfgbatch29" 

#     workspaces { 
#       name = "myworkspace" 
#     } 
#   } 
# }

# terraform {
#   backend "remote" {
#     hostname = "app.terraform.io"
#     organization = "gfgbatch29"

#     workspaces {
#       name = "myworkspace"
#     }
#   }
# }

terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
}



module "myec2module" {
  source = "./myec2module"
  instance_type_mod="t2.micro"
  ami_id_mod="ami-053b0d53c279acc90"
  name="myec2mod"
  name_sg = "mysgmod"
}

module "myec2modulepub" {
  source  = "iampsrv/myec2module/pranjal"
  version = "1.0.0"
  instance_type_mod="t2.micro"
  ami_id_mod="ami-053b0d53c279acc90"
  name="myec2publishmod"
  name_sg = "mysgmod"
  # insert the 4 required variables here
}

# module "myec2modulenewpub" {
#   source  = "iampsrv/batch19tfmod/pranjal"
#   version = "1.0.0"
#   instance_type_mod="t3.micro"
#   ami_id_mod="ami-053b0d53c279acc90"
#   name="myec2newpublishmod"
#   name_sg = "mynewsgmod"
#   # insert the 4 required variables here
# }


module "batch29" {
  source  = "iampsrv/batch29/project"
  version = "1.0.0"
  instance_type_mod="t2.micro"
  ami_id_mod="ami-053b0d53c279acc90"
  name="myec2publishmod29"
  name_sg = "mysgmod29"
  # insert the 4 required variables here
}
#########################
resource "aws_instance" "example" {
  count         = 3
  ami           = "ami-12345678"
  instance_type = "t2.micro"
}
#########################
variable "servers" {
  default = {
    server1 = "t2.micro"
    server2 = "t3.micro"
  }
}

resource "aws_instance" "example" {
  for_each      = var.servers
  ami           = "ami-12345678"
  instance_type = each.value
  tags = {
    Name = each.key
  }
}


#########################
# Define a map of instances with their specific details
variable "ec2_configs" {
  default = {
    instance1 = {
      ami           = "ami-0c55b159cbfafe1f0"  # Ubuntu
      instance_type = "t2.micro"
      name          = "WebServer"
    }
    instance2 = {
      ami           = "ami-07d02ee1eeb0c996c"  # Amazon Linux
      instance_type = "t3.micro"
      name          = "AppServer"
    }
    instance3 = {
      ami           = "ami-06ca3ca175f37dd66"  # Debian
      instance_type = "t3a.micro"
      name          = "DBServer"
    }
  }
}

resource "aws_instance" "custom_instances" {
  for_each = var.ec2_configs

  ami           = each.value.ami
  instance_type = each.value.instance_type

  tags = {
    Name = each.value.name
  }
}
################

variable "amis"           { default = ["ami-0c55b159cbfafe1f0", "ami-07d02ee1eeb0c996c", "ami-06ca3ca175f37dd66"] }
variable "instance_types" { default = ["t2.micro", "t3.micro", "t3a.micro"] }
variable "names"          { default = ["WebServer", "AppServer", "DBServer"] }

resource "aws_instance" "demo" {
  count = length(var.amis)          # == 3

  ami           = var.amis[count.index]
  instance_type = var.instance_types[count.index]

  tags = { Name = var.names[count.index] }
}
