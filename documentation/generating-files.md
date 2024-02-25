# To install OpenShift Container Platform on Amazon Web Services (AWS) using UPI, you must generate the files that the installation program needs to deploy your 
# cluster and modify them so that the cluster creates only the machines that it will use.

# You generate and customize the 1) install-config.yaml file 2) Kubernetes manifests 3) Ignition config files.
 
# https://docs.openshift.com/container-platform/4.14/installing/installing_aws/ins

# 1. Create the install-config.yaml file.

# 2. Back-up the install.config.yaml.
- The install-config.yaml file is consumed during the installation process. If you want to reuse the file, you must back it up now.

# 3. Configuring the cluster-wide proxy during installation
- I ignored this in my lab

# 4. Create the Kubernetes manifest and ignition config files.
https://docs.openshift.com/container-platform/4.14/installing/installing_aws/installing-aws-user-infra.html

- You must generate the Kubernetes manifest and Ignition config files that the cluster needs to configure the machines.

# 5. Extracting the infrastructure name

