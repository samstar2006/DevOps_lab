# # Create/Launch an AWS EC2 Instance(Ansible Managed Node2) to host Docker

# resource "aws_instance" "AnsibleMN-DockerHost" {
#   ami                         = var.ami
#   instance_type               = var.instance_type
#   key_name                    = var.key_name
#   vpc_security_group_ids      = [aws_security_group.MyLab_Sec_Group.id]
#   subnet_id                   = aws_subnet.MyLab-Subnet1.id
#   associate_public_ip_address = true
#   user_data                   = file("./Docker.sh")

#   tags = {
#     Name = "AnsibleMN-DockerHost"
#   }
# }

# resource "aws_eip" "AnsibleMN-EIP" {
#   instance = aws_instance.AnsibleMN-DockerHost.id
# }

# resource "aws_eip_association" "AnsibleMN-EIP-Association" {
#   instance_id   = aws_instance.AnsibleMN-DockerHost.id
#   allocation_id = aws_eip.AnsibleMN-EIP.id
# }

# output "AnsibleMN-EIP" {
#   value = aws_eip.AnsibleMN-EIP.public_ip
# }



