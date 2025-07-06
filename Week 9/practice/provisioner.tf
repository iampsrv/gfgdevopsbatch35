resource "aws_instance" "stage_instance" {
  instance_type          = var.instance_type
  ami                    = var.image_id
  key_name               = "gfgbatch29"
  subnet_id = aws_subnet.subnet1.id
  vpc_security_group_ids = [aws_security_group.mysg.id]

  provisioner "file" {
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("gfgbatch29.pem")
      host        = aws_instance.stage_instance.public_ip
    }
    source      = "abc.sh"
    destination = "/tmp/abc.sh"
  }
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("gfgbatch29.pem")
    host        = aws_instance.stage_instance.public_ip
  }
  provisioner "remote-exec" {

    
    inline = [
      "chmod +x /tmp/abc.sh",
      "/tmp/abc.sh",
    ]
  }

  tags = {
    Name = "provisionerexample-instance"
  }
}