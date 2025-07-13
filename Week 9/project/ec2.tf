resource "aws_instance" "web" {
  ami           = var.image_id
  instance_type = var.instance_type
  associate_public_ip_address = true
  availability_zone = var.availability_zone_names[0]
  subnet_id     = aws_subnet.mysubnet1.id
  user_data                   = file("start.sh")
  key_name = "gfgbatch35new"
  vpc_security_group_ids = [aws_security_group.mysg.id]
  depends_on = [
    aws_security_group.mysg
  ]
  tags = {
    Name = "myec2instance1tf"
  }
}

resource "aws_instance" "web1" {
  ami           = var.image_id
  instance_type = var.instance_type
  associate_public_ip_address = true
  availability_zone = var.availability_zone_names[1]
  subnet_id     = aws_subnet.mysubnet2.id
  user_data                   = file("start.sh")
  key_name = "gfgbatch35new"
  vpc_security_group_ids = [aws_security_group.mysg.id]
  depends_on = [
    aws_security_group.mysg
  ]
  tags = {
    Name = "myec2instance2tf"
  }
}