resource "aws_instance" "web" {
  ami                         = var.image_id
  instance_type               = var.instance_type
  associate_public_ip_address = true
  key_name                    = "gfgbatch29"
  subnet_id = aws_subnet.subnet1.id
  vpc_security_group_ids = [aws_security_group.mysg.id]
  user_data       = file("start.sh")

  tags = {
    Name = "HelloWorld"
  }
}

resource "aws_instance" "web1" {
  ami                         = var.image_id
  instance_type               = var.instance_type
  associate_public_ip_address = true
  key_name                    = "gfgbatch29"
  subnet_id = aws_subnet.subnet1.id
  vpc_security_group_ids = [aws_security_group.mysg.id]
  user_data       = file("start.sh")

  tags = {
    Name = "HelloWorld1"
  }
}

