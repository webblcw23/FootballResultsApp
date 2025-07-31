

resource "aws_instance" "server" {

ami = "ami-0f4f4482537714bd9"
instance_type = "t2.micro"
subnet_id = var.sn
security_groups = [var.sg]
tags = {
    Name = "myserver"
  }
}