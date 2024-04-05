output "public_instance_id" {
  value = aws_instance.public_instance.id
}

output "almost_private_instance_id" {
  value = aws_instance.almost_private_instance.id
}

output "public_instance_public_dns" {
  value = aws_instance.public_instance.public_dns  
}

output "almost_private_instance_public_dns" {
  value = aws_instance.almost_private_instance.public_dns
}