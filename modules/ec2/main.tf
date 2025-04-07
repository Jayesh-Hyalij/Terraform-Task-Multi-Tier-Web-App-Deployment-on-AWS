# Web Server EC2 Instance
resource "aws_instance" "web" {
  ami                    = var.web_ami
  instance_type          = var.instance_type
  subnet_id              = var.public_subnet_ids[0]
  vpc_security_group_ids = [var.web_sg_id]
  key_name               = var.key_name
  user_data              = <<-EOF
              #!/bin/bash
              sudo apt-get update -y
              sudo apt-get install nginx -y
              sudo systemctl start nginx
              sudo systemctl enable nginx
              EOF

  tags = {
    Name = "web-server"
  }
}

# Database Server EC2 Instance
resource "aws_instance" "db" {
  ami                    = var.db_ami
  instance_type          = var.instance_type
  subnet_id              = var.private_subnet_ids[0]
  vpc_security_group_ids = [var.db_sg_id]
  key_name               = var.key_name

  tags = {
    Name = "db-server"
  }
}
