!/bin/bash

# Ensure we start in the /opt directory
cd /opt

# Install necessary packages
sudo yum install java-1.8.0-openjdk -y


# Download the latest Nexus tarball
yum install wget -y
wget -O nexus.tar.gz https://download.sonatype.com/nexus/3/latest-unix.tar.gz

# Extract the Nexus tarball
tar -xvf nexus.tar.gz

# Rename the extracted directory for simplicity
mv nexus-3.* nexus3

# Change ownership for ec2-user
sudo chown -R ec2-user:ec2-user nexus3/

# If the sonatype-work directory exists, change its ownership too
if [ -d "sonatype-work" ]; then
    sudo chown -R ec2-user:ec2-user sonatype-work/
fi

# Configure Nexus to run as ec2-user
echo 'run_as_user="ec2-user"' | sudo tee -a /opt/nexus3/bin/nexus.rc

# Create a systemd service file for Nexus
echo '[Unit]
Description=nexus service
After=network.target

[Service]
Type=forking
LimitNOFILE=65536
ExecStart=/opt/nexus3/bin/nexus start
ExecStop=/opt/nexus3/bin/nexus stop
User=ec2-user
Restart=on-abort
Environment=INSTALL4J_JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk


[Install]
WantedBy=multi-user.target' | sudo tee /etc/systemd/system/nexus.service

# Reload systemd and enable & start Nexus
sudo systemctl daemon-reload
sudo systemctl enable nexus
sudo systemctl start nexus


