#!/bin/bash
sudo apt-get update -y
#sudo apt-get install -y httpd #for
sudo apt-get install -y apache2
sudo systemctl start httpd.service
sudo systemctl enable httpd.service
echo "Hello from EC2 user data!" > /var/www/html/index.html
