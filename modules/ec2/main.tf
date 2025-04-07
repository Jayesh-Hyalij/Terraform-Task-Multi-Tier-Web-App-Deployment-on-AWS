resource "aws_instance" "web_server" {
  count                  = length(var.public_subnet_ids)
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.micro"
  subnet_id              = var.public_subnet_ids[count.index]
  vpc_security_group_ids = [var.web_security_group]
  key_name               = "terraform_task"
  user_data              = <<-EOF
              #!/bin/bash
              apt-get update
              apt-get install -y nginx
              systemctl start nginx
              systemctl enable nginx
              EOF

  tags = {
    Name = "web-server-${count.index + 1}"
  }
}

resource "aws_instance" "db_server" {
  count                  = length(var.private_subnet_ids)
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.micro"
  subnet_id              = var.private_subnet_ids[count.index]
  vpc_security_group_ids = [var.db_security_group]
  key_name               = "terraform_task"
  user_data              = <<-EOF
              #!/bin/bash
              apt-get update
              apt-get install -y mysql-server
              systemctl start mysql
              systemctl enable mysql
              EOF

  tags = {
    Name = "db-server-${count.index + 1}"
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}
