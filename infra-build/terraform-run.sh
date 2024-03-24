#!/usr/bin/bash

infra_name=$(jq -r .infraID ~/metadata.json)

terraform apply -var "infra_name=$infra_name" -var "cluster_name=$CLUSTER_NAME" -var "region=$REGION"