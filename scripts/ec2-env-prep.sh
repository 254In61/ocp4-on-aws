#!/usr/bin/bash
sudo apt update && sudo apt install -y jq wget curl unzip ansible
sudo pip install boto3
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && unzip awscliv2.zip
sudo ./aws/install
