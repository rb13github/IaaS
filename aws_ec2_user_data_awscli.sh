#!/bin/bash
set -euo pipefail
cd /root

# Update and install dependencies
apt-get update -y
apt-get install -y curl unzip jq

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
./aws/install
