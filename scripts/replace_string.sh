#!/usr/bin/bash

# Why this script?
# Ansible has this irritating character of converting any double quotes into single quotes when it reads a string into a variable.
# When pasted like that in the install-config.yaml, the manifests build cmd fails!

# After trying a number of ansible modules like slurp, lookup etc, I settled to using a bash script in the backgroud to do sed.


file_path=install-dir/install-config.yaml
old_string=pull_secret_comes_here
new_string=$(cat secrets/pull-secret.txt)

# Perform string replacement using sed
sed -i "s/${old_string}/${new_string}/g" "$file_path"

