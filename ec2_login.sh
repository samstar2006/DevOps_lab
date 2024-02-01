#! /bin/bash

#jenkins server
ssh -i EC2.pem ec2-user@54.157.6.45
jenkinsadmin
admin
http://54.157.6.45:8080/

#AnsibleCN-Ansible #ansibleansible
ssh -i EC2.pem ec2-user@18.207.205.2
ssh -i EC2.pem ansibleadmin@18.207.205.2

#AnsibleMN-ApacheTomcat ansibleansible
ssh -i EC2.pem ec2-user@100.27.28.67
ssh -i EC2.pem ansibleadmin@100.27.28.67

AnsibleMN-DockerHost
ssh -i EC2.pem ec2-user@184.72.185.126
ssh -i EC2.pem ansibleadmin@184.72.185.126

#sonatype nexus
ssh -i EC2.pem ec2-user@3.95.222.50
http://3.95.222.50:8081
admin
admin1123