output "ec2_b_public_ip" {
  description = "The public IP address of EC2-B"
  value       = aws_eip.ec2_b_ip.public_ip
}
