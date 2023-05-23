output "apache_server_ids" {
  value = aws_instance.apache-server[*].id
}