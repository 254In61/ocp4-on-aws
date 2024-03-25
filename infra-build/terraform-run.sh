#!/usr/bin/bash
echo "" && echo "===> git pull"
git pull

echo "" && echo "===> Extract hosted zone ID"
hosted_zone_id=$(aws route53 list-hosted-zones-by-name --dns-name $BASE_DOMAIN --query 'HostedZones[0].Id' --output text | sed 's#/hostedzone/##')

echo "" && echo "===> Extract infra name"
infra_name=$(jq -r .infraID ~/metadata.json)

echo "" && echo "===> Run terraform apply with variables included on CLI"
terraform apply -var "infra_name=$infra_name" -var "cluster_name=$CLUSTER_NAME" -var "region=$REGION" -var "hosted_zone_id=$hosted_zone_id" -var "hosted_zone_name=$BASE_DOMAIN"
