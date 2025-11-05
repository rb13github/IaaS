#!/bin/bash
set -euo pipefail
cd /root

# Update and install dependencies
apt-get update -y
apt-get install -y apache2
systemctl start apache2
systemctl enable apache2
chown -R www-data:www-data /var/www/html
