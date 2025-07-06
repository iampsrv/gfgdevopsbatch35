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