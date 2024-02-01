# # # Create/Launch an AWS EC2 Instance(Ansible Managed Node1) to host Apache Tomcat server

# resource "aws_instance" "AnsibleManagedNode1" {
#   ami                         = var.ami
#   instance_type               = var.instance_type
#   key_name                    = var.key_name
#   vpc_security_group_ids      = [aws_security_group.MyLab_Sec_Group.id]
#   subnet_id                   = aws_subnet.MyLab-Subnet1.id
#   associate_public_ip_address = true
#   user_data                   = file("./AnsibleManagedNode.sh")

#   tags = {
#     Name = "AnsibleMN-ApacheTomcat"
#   }
# }

# resource "aws_eip" "AnsibleManagedNodeEIP" {
#   instance = aws_instance.AnsibleManagedNode1.id
# }

# resource "aws_eip_association" "AnsibleManagedNodeEIPAssociation" {
#   instance_id   = aws_instance.AnsibleManagedNode1.id
#   allocation_id = aws_eip.AnsibleManagedNodeEIP.id
# }

# output "AnsibleManagedNodeEIP" {
#   value = aws_eip.AnsibleManagedNodeEIP.public_ip
# }

