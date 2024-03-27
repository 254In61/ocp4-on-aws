#!/usr/bin/bash

# Script to confirm cluster scheduler is put to false.

# mastersSchedulable=yq -p yaml -o json $HOME/manifests/cluster-scheduler-02-config.yml | jq -c .spec.mastersSchedulable

output=cat $HOME/manifests/cluster-scheduler-02-config.yml | grep mastersSchedulable

# Check if the mastersSchedulable equals false
if [ "output" != "mastersSchedulable: false" ]; then
    echo "FAIL"
    exit 1
fi

# Continue with the script if the variable equals something
echo "PASS"