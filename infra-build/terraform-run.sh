#!/usr/bin/bash
echo "" && echo "===> git pull for any repo updates"
git pull

echo "" && echo "===> Change directory backwards to run ansible"
cd .. && ansible-playbook ignition-files.yml


echo "" && echo "===> Change directory back to run terraform"
echo "" && echo "===> Run terraform apply"
cd infra-build && terraform apply
