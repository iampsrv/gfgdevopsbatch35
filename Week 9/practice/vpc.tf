resource "aws_vpc" "myvpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "myvpc-tf"
  }
}

resource "aws_subnet" "subnet1" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "subnet1-tf"
  }
}

resource "aws_subnet" "subnet2" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "subnet2-tf"
  }
}

resource "aws_subnet" "subnet3" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "subnet3-tf"
  }
}

resource "aws_subnet" "subnet4" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = "10.0.4.0/24"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "subnet4-tf"
  }
}


resource "aws_internet_gateway" "myigw" {
  vpc_id = aws_vpc.myvpc.id

  tags = {
    Name = "myigw-tf"
  }
}

resource "aws_route_table" "myrt" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.myigw.id
  }

  tags = {
    Name = "myrt-tf"
  }
}

resource "aws_route_table_association" "rtasubnet1" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.myrt.id
}
resource "aws_route_table_association" "rtasubnet2" {
  subnet_id      = aws_subnet.subnet2.id
  route_table_id = aws_route_table.myrt.id
}