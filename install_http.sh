#!/bin/bash
sudo apt-get update -y 
#use yum for linux or Redhat
#sudo apt-get install -y httpd #for linux
sudo apt-get install -y apache2
sudo systemctl start apache2
sudo systemctl enable apache2
sudo chown -R www-data:www-data /var/www/html
echo "Hello from EC2 user data!" > /var/www/html/index.html
