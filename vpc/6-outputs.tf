output "vpc_id" {
  value = aws_vpc.this.id
}

output "private_subnet_ids" {
  value = aws_subnet.private[*].id
}

output "public_subnet_ids" {
  value = aws_subnet.public[*].id
}

output "public_ip" {
  value = aws_eip.this.public_ip
}

output "eip_id" {
  value = aws_eip.this.id
}
