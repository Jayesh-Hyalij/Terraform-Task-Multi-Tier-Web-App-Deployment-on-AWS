output "web_server_public_ip" {
  value = aws_instance.web_server[*].public_ip
}

output "db_server_private_ip" {
  value = aws_instance.db_server[*].private_ip
}
