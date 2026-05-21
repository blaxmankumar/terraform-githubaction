
# VPC

resource "aws_vpc" "main" {

  cidr_block = var.vpc_cidr

  tags = {
    Name = "terraform-vpc"
  }
}


# Public Subnet

resource "aws_subnet" "public" {

  vpc_id = aws_vpc.main.id

  cidr_block = var.subnet_cidr

  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet"
  }
}

# Internet Gateway

resource "aws_internet_gateway" "gw" {

  vpc_id = aws_vpc.main.id

  tags = {
    Name = "terraform-igw"
  }
}
# Route Table


resource "aws_route_table" "rt" {

  vpc_id = aws_vpc.main.id

  route {

    cidr_block = "0.0.0.0/0"

    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "terraform-rt"
  }
}

# Route Table Association


resource "aws_route_table_association" "rta" {

  subnet_id = aws_subnet.public.id

  route_table_id = aws_route_table.rt.id
}

# Security Group


resource "aws_security_group" "sg" {

  name = "terraform-sg"

  vpc_id = aws_vpc.main.id

  # SSH Access

  ingress {

    description = "SSH"

    from_port = 22
    to_port   = 22

    protocol = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTP Access

  ingress {

    description = "HTTP"

    from_port = 80
    to_port   = 80

    protocol = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound Traffic

  egress {

    from_port = 0
    to_port   = 0

    protocol = "-1"

    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "terraform-sg"
  }
}


# EC2 Instance


resource "aws_instance" "server" {

  ami = var.ami_id

  instance_type = var.instance_type

  subnet_id = aws_subnet.public.id

  vpc_security_group_ids = [aws_security_group.sg.id]

  tags = {
    Name = "Terraform-Server"
  }
}


# S3 Bucket


resource "aws_s3_bucket" "bucket" {

  bucket = var.bucket_name

  tags = {
    Name = "terraform-bucket"
  }
}
