# # # # Create/Launch an AWS EC2 Instance to host Sonatype Nexus

# resource "aws_instance" "Nexus" {
#   ami                         = var.ami
#   instance_type               = var.instance_type_for_nexus
#   key_name                    = var.key_name
#   vpc_security_group_ids      = [aws_security_group.MyLab_Sec_Group.id]
#   subnet_id                   = aws_subnet.MyLab-Subnet1.id
#   associate_public_ip_address = true
#   user_data                   = file("./InstallNexus.sh")

#   tags = {
#     Name = "Nexus-Server"
#   }
# }

# resource "aws_eip" "Nexus_EIP" {
#   instance = aws_instance.Nexus.id
# }

# resource "aws_eip_association" "Nexus_EIP_Association" {
#   instance_id   = aws_instance.Nexus.id
#   allocation_id = aws_eip.Nexus_EIP.id
# }

# output "Nexus_IP" {
#   value = aws_eip.Nexus_EIP.public_ip
# }




