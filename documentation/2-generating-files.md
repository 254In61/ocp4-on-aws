# To install OpenShift Container Platform on Amazon Web Services (AWS) using UPI, you must generate the files that the installation program needs to deploy your cluster and modify them so that the cluster creates only the machines that it will use.
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

- The installation configuration file transforms into the Kubernetes manifests >> The manifests wrap into the Ignition configuration files, which are later used to configure the cluster machines.

-  The Ignition config files that the OpenShift Container Platform installation program generates contain certificates that expire after 24 hours, which are then renewed at that time. If the cluster is shut down before renewing the certificates and the cluster is later restarted after the 24 hours have elapsed, the cluster automatically recovers the expired certificates. The exception is that you must manually approve the pending node-bootstrapper certificate signing requests (CSRs) to recover kubelet certificates. See the documentation for "Recovering from expired control plane certificates" for more information.

- *** NB:*** It is recommended that you use Ignition config files within 12 hours after they are generated because the 24-hour certificate rotates from 16 to 22 hours after the cluster is installed. By using the Ignition config files within 12 hours, you can avoid installation failure if the certificate update runs during installation.

4.1) Generate the K8s manifests for the cluster.

   $ openshift-install create manifests --dir install-dir/
   
   ! Expected output 

   INFO Credentials loaded from the "default" profile in file "/home/amaseghe/.aws/credentials" 
   INFO Consuming Install Config from target directory 
   INFO Manifests created in: install-dir/manifests and install-dir/openshift 

4.2) Remove the Kubernetes manifest files that define the control plane machines & control machine set:
   This is to prevent the cluster from automatically generating control plane machines.
   
   $ rm -f install-dir/openshift/99_openshift-cluster-api_master-machines-*.yaml
   $ rm -rf install-dir/openshift/99_openshift-machine-api_master-control-plane-machine-set.yaml

4.3) Because you create and manage the worker machines yourself, you do not need to initialize these.

  $ rm -rf install-dir/openshift/99_openshift-cluster-api_worker-machineset-*.yaml

4.4) Check that the mastersSchedulable parameter in the <installation_directory>/manifests/cluster-scheduler-02-config.yml Kubernetes manifest file is set to false. This setting prevents pods from being scheduled on the control plane machines:
- 	If you are installing a three-node cluster, skip this step to allow the control plane nodes to be schedulable.
- NB: When you configure control plane nodes from the default unschedulable to schedulable, additional subscriptions are required. This is because control plane nodes then become compute nodes.

4.5) OPTIONAL: If you do not want the Ingress Operator to create DNS records on your behalf, remove the privateZone and publicZone sections from the <installation_directory>/manifests/cluster-dns-02-config.yml DNS configuration file
- If you do so, you must add ingress DNS records manually in a later step.
- I didn't touch anything here for my lab

4.6) To create the Ignition configuration files, run the following command:
 $ openshift-install create ignition-configs --dir install-dir/

INFO Consuming OpenShift Install (Manifests) from target directory 
INFO Consuming Master Machines from target directory 
INFO Consuming Worker Machines from target directory 
INFO Consuming Common Manifests from target directory 
INFO Consuming Openshift Manifests from target directory 
INFO Ignition-Configs created in: install-dir and install-dir/auth

** The step will consume the files in /manifests and /openshift, then delete the directories at the end while create the .ign files.
- Ignition config files are created for the bootstrap, control plane, and compute nodes in the installation directory. 
- The kubeadmin-password and kubeconfig files are created in the ./<installation_directory>/auth directory:

# 5. Extracting the infrastructure name
- The Ignition config files contain a unique cluster identifier that you can use to uniquely identify your cluster in Amazon Web Services (AWS). 
- The infrastructure name is also used to locate the appropriate AWS resources during an OpenShift Container Platform installation. 
- The provided CloudFormation templates contain references to this infrastructure name, so you must extract it.
- The output of this command is your cluster name and a random string.

 $ jq -r .infraID install-dir/metadata.json 
ocp4-apse2-allan-g9kff
