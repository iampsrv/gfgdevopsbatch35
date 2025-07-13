locals {
  workers = toset(["worker-1", "worker-2"])
}

resource "aws_instance" "worker" {
  for_each = local.workers

  ami                         = "ami-020cba7c55df1f615"
  instance_type               = "t2.medium"
  associate_public_ip_address = true
  availability_zone           = "us-east-1a"
  subnet_id                   = "subnet-0b81e7dc6023ee381"
  key_name                    = "gfgbatch35new"
  security_groups             = ["sg-078e9525b45684489"]

  tags = {
    Name = each.value
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("gfgbatch35new.pem")
    host        = self.public_ip
  }

  provisioner "file" {
    source      = "worker.sh"
    destination = "/home/ubuntu/worker.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /home/ubuntu/worker.sh",
      "sudo /home/ubuntu/worker.sh"
    ]
  }
}
