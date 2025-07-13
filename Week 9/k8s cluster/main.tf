resource "aws_instance" "master" {
  ami                         = "ami-020cba7c55df1f615"
  instance_type               = "t2.large"
  associate_public_ip_address = true
  availability_zone           = "us-east-1a"
  subnet_id                   = "subnet-0b81e7dc6023ee381"
  key_name                    = "gfgbatch35new"
  security_groups             = ["sg-078e9525b45684489"]

  tags = {
    Name = "master"
  }

  # 🔐 Shared SSH connection config
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("gfgbatch35new.pem")
    host        = self.public_ip
  }

  # 📂 Upload master.sh to the instance
  provisioner "file" {
    source      = "master.sh"
    destination = "/home/ubuntu/master.sh"
  }

  # 🧾 Run the script remotely
  provisioner "remote-exec" {
    inline = [
      "chmod +x /home/ubuntu/master.sh",
      "sudo /home/ubuntu/master.sh"
    ]
  }
}
