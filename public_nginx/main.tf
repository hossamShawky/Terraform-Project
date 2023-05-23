resource "aws_instance" "nginx-proxy" {
  count                       = length(var.public_subnets_ids)
  ami                         = var.ami_id
  vpc_security_group_ids      = [var.securit_group_ids]
  key_name                    = var.key_name
  associate_public_ip_address = true
  subnet_id                   = var.public_subnets_ids[count.index]
  instance_type               = var.instance_type
  provisioner "local-exec" {
    command = "echo ${self.public_ip} >> ./public_ips.txt"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update -y",
      "sudo apt install nginx -y",
      "sudo systemctl enable nginx",
      # Replace nginx configuration with local configuration
      "sudo sed -i \"52 i proxy_pass http://${var.private_load_balancer_dns};\" /etc/nginx/sites-available/default",
      "sudo systemctl restart nginx"
    ]
  }
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("./mykey.pem")
    host        = self.public_ip
  }


  tags = {
    Name = var.nginx_tag
  }

}   