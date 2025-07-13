variable "availability_zone_names" {
  type    = list(string)
  default = ["us-east-1a","us-east-1b"]
}

# variable "availability_zone_names" {
#   type = string
#   default = "us-east-1a"
# }

# variable "AWS_ACCESS_KEY" { }
# variable "AWS_SECRET_KEY" { }

variable "image_id" {
  type = string
  default = "ami-020cba7c55df1f615"
}

variable "instance_type" {
  type = string
  default = "t3.micro"
}


output "instance_ip_addr_web" {
  value = aws_instance.web.private_ip
}

output "instance_ip_addr_web1" {
  value = aws_instance.web1.private_ip
}

output "instance_ip_addr_webp" {
  value = aws_instance.web.public_ip
}

output "instance_ip_addr_web1p" {
  value = aws_instance.web1.public_ip
}