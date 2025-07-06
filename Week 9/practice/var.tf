variable "image_id" {
  type = string
  default = "ami-04b70fa74e45c3917"
}

variable "instance_type" {
  type = string
  default = "t3.micro"
}

# variable "AWS_SECRET_KEY" {
#   type = string
# }

# variable "AWS_ACCESS_KEY" {
#   type = string
# }

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