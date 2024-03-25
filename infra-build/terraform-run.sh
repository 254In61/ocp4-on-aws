#!/usr/bin/bash
echo "" && echo "===> git pull for any repo updates"
git pull

echo "" && echo "===> Run terraform apply"
terraform apply
