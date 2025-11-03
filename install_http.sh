#!/bin/bash
sudo apt-get update -y
sudo apt-get install -y httpd
sudo systemctl start httpd
sudo systemctl enable httpd
echo "Hello from EC2 user data!" > /var/www/html/index.html
