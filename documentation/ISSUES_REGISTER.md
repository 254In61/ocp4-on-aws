# 1: $ openshift-install create manifests --dir install-dir/
ERROR failed to fetch Master Machines: failed to load asset "Install Config": failed to create install config: failed to unmarshal install-config.yaml: error converting YAML to JSON: yaml: line 11: could not find expected ':' 

- I hadn't put the correct spacing for from the ---BEGIN CERTIFICATE ---- to ---END CERTIFICATE --- on the install-config.yaml

# 2: $ openshift-install create manifests --dir install-dir/
ERROR failed to fetch Master Machines: failed to load asset "Install Config": failed to create install config: failed to unmarshal install-config.yaml: error converting YAML to JSON: yaml: unmarshal errors: 
ERROR   line 32: key "additionalTrustBundlePolicy" already set in map 

- For some reason this line was appearing twice on the install-config.yaml.

# 3: $ openshift-install create manifests --dir install-dir/
ERROR failed to fetch Master Machines: failed to load asset "Install Config": failed to create install config: invalid "install-config.yaml" file: [proxy.httpProxy: Invalid value: "http://amaseghe:ccie@2013@10.128.96.1:8001": proxy value is part of the cluster networks, proxy.httpsProxy: Invalid value: "https://amaseghe:ccie@2013@10.128.96.1:8002": proxy value is part of the cluster networks]

- Decided to hash out the PROXY and the related TrustBundle story.

# 4 : amaseghe@black-panther:~/developer/own/openshift/ocp-on-aws$ openshift-install wait-for bootstrap-complete --dir install-dir --log-level=info
INFO Waiting up to 20m0s (until 9:56PM AEST) for the Kubernetes API at https://api.ocp4-apse2-allan.lab-aws.ldcloud.com.au:6443... 
INFO API v1.27.10+28ed2d7 up                      
INFO Waiting up to 30m0s (until 10:06PM AEST) for bootstrapping to complete... 
INFO Use the following commands to gather logs from the cluster 
INFO openshift-install gather bootstrap --help    
ERROR Bootstrap failed to complete: timed out waiting for the condition 
ERROR Failed to wait for bootstrapping to complete. This error usually happens when there is a problem with control plane hosts that prevents the control plane operators from creating the control plane. 

- NO idea why this failed.. I will start again tommorow.. Will be more efficient this time and will be scripting my steps as I go along.
- I will keep on this until I manage to install!