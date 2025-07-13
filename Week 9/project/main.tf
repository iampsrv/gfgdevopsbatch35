# terraform {
#   required_providers {
#     aws = {
#       source = "hashicorp/aws"
#       version = "6.2.0"
#     }
#   }
# }

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
    
#     organization = "gfgbatch35" 

#     workspaces { 
#       name = "myworkspace" 
#     } 
#   } 
# }

# terraform {
#   backend "remote" {
#     hostname = "app.terraform.io"
#     organization = "gfgbatchninteen"

#     workspaces {
#       name = "gfgws"
#     }
#   }
# }

terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
}