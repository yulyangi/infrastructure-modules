resource "aws_instance" "this" {
  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [aws_default_security_group.this.id]
  # associate_public_ip_address = true
  user_data = file("./entry-script.sh")

  tags = {
    "Name" = "Ubuntu"
  }
}

resource "aws_eip_association" "this" {
  instance_id   = aws_instance.this.id
  allocation_id = var.aws_eip_id
}
