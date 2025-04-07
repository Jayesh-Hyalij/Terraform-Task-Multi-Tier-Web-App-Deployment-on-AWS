output "web_instance_id" {
  value = aws_instance.web.id
}

output "db_instance_id" {
  value = aws_instance.db.id
}

output "web_public_ip" {
  value = aws_instance.web.public_ip
}
