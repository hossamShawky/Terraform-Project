output "nginx_proxy_ids" {
  value = aws_instance.nginx-proxy[*].id
}