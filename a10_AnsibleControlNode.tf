# # Create an AWS EC2 Instance to host Ansible Controller (Control node)

# resource "aws_instance" "AnsibleController" {
#   ami                         = var.ami
#   instance_type               = var.instance_type
#   key_name                    = var.key_name
#   vpc_security_group_ids      = [aws_security_group.MyLab_Sec_Group.id]
#   subnet_id                   = aws_subnet.MyLab-Subnet1.id
#   associate_public_ip_address = true
#   user_data                   = file("./InstallAnsibleCN.sh")

#   tags = {
#     Name = "Ansible-ControlNode"
#   }
# }

# resource "aws_eip" "AnsibleEIP" {
#   instance = aws_instance.AnsibleController.id
# }

# resource "aws_eip_association" "AnsibleEIPAssociation" {
#   instance_id   = aws_instance.AnsibleController.id
#   allocation_id = aws_eip.AnsibleEIP.id
# }

# output "AnsibleEIP" {
#   value = aws_eip.AnsibleEIP.public_ip
# }

