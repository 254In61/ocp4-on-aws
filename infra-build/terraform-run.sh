#!/usr/bin/bash
echo "" && echo "===> git pull"
git pull

echo "" && echo "===> Extract infra name"
infra_name=$(jq -r .infraID ~/metadata.json)

echo "" && echo "===> Run terraform apply with variables included on CLI"
terraform apply -var "infra_name=$infra_name" -var "cluster_name=$CLUSTER_NAME" -var "region=$REGION"