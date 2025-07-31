# Create 1 vpc, 1 subnet and 1 sucrity group

resource "aws_vpc" "mpvpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "mpvpc"
  }
}

resource "aws_subnet" "sn" {
  vpc_id            = aws_vpc.mpvpc.id
  cidr_block        = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone = "eu-west-2a"
    tags = {
        Name = "pb_sn1"
    }

}

resource "aws_security_group" "sg" {
  vpc_id = aws_vpc.mpvpc.id
  name   = "my_sg"
  description = "Public security group"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

}