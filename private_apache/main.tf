# get userdata
data "template_file" "apache_user_data" {
  template = file("apache-user-data.sh")
}

resource "aws_instance" "apache-server" {
  count                       = 2
  ami                         = var.ami_id
  vpc_security_group_ids      = [var.securit_group_ids]
  key_name                    = var.key_name
  associate_public_ip_address = false
  subnet_id                   = var.private_subnets_ids[count.index]
  instance_type               = var.instance_type
  user_data                   = data.template_file.apache_user_data.rendered
  provisioner "local-exec" {
    command = "echo ${self.private_ip} >> ./private_ips.txt"
  }
  tags = {
    Name = var.apache_tag
  }

}   