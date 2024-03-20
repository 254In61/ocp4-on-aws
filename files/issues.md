Issue 1
=======
ubuntu@ip-10-0-1-7:~$ openshift-install version
-bash: /usr/local/bin/openshift-install: cannot execute binary file: Exec format error
ubuntu@ip-10-0-1-7:~$ oc version
-bash: /usr/local/bin/oc: cannot execute binary file: Exec format error

Solution
-------
If you have the wrong openshift-installer or openshift-command line packages for the on the wrong AWS Machine Architecture

Issue 2
========
Invalid value: \"OpenShiftSDN\": networkType OpenShiftSDN is deprecated, please use OVNKubernetes"

Solution
--------
Replace the networkType

Issue 3
=======
UnauthorizedOperation: You are not authorized to perform this operation. User: arn:aws:sts::********:assumed-role/Ec2SSMRole/i-037a0e1a4e854add6 is not authorized to perform: ec2:DescribeAvailabilityZones because no identity-based policy allows the ec2:DescribeAvailabilityZones action

Solution
--------
Ensure the IAM role attached to the Bastion EC2 has the above rights.

Issue 4
=======
Invalid value: \"m4.xlarge\": instance type supported architectures [amd64] do not match specified architecture arm64, compute[0].platform.aws.type

Solution
--------
Changed to m6g.large for worker & m6g.xlarge for master

Issue 5
========
AccessDenied: User: arn:aws:sts::****:assumed-role/Ec2SSMRole/i-037a0e1a4e854add6 is not authorized to perform: route53:ListHostedZones because no identity-based policy allows the route53:ListHostedZones action

Solution
--------
Ensure the IAM role attached to the Bastion EC2 has the above rights.

Issue 6
========
fatal: [localhost]: FAILED! => {"changed": true, "cmd": ["openshift-install", "create", "manifests", "--dir", "/home/ubuntu/"], "delta": "0:00:02.730667", "end": "2024-03-18 07:00:57.097329", "msg": "non-zero return code", "rc": 1, "start": "2024-03-18 07:00:54.366662", "stderr": "level=info msg=Credentials loaded from the AWS config using \"EC2RoleProvider\" provider\nlevel=info msg=Consuming Install Config from target directory\nlevel=fatal msg=failed to fetch Openshift Manifests: failed to generate asset \"Openshift Manifests\": AWS credentials provided by EC2RoleProvider are not valid for default credentials mode", "stderr_lines": ["level=info msg=Credentials loaded from the AWS config using \"EC2RoleProvider\" provider", "level=info msg=Consuming Install Config from target directory", "level=fatal msg=failed to fetch Openshift Manifests: failed to generate asset \"Openshift Manifests\": AWS credentials provided by EC2RoleProvider are not valid for default credentials mode"], "stdout": "", "stdout_lines": []}

Solution
--------
- The openshift-install tool will then use the AWS credentials from the CLI configuration.
- In this case, the credentials are read from [default] profile in the ~/.aws/credentials & ~/.aws/config

Issue 7
=======
"msg": "[Errno 8] Exec format error: b'aws'", "rc": 8}

Solution
--------
Had installed AWS for the wrong machine architecture

Issue 8
=======
- $ openshift-install wait-for bootstrap-complete --dir=$HOME --log-level info
INFO Waiting up to 20m0s (until 2:33AM UTC) for the Kubernetes API at https://api.ocp4-apse2-99.lab-aws.ldcloud.com.au:6443... 
ERROR Attempted to gather ClusterOperator status after wait failure: listing ClusterOperator objects: Get "https://api.ocp4-apse2-99.lab-aws.ldcloud.com.au:6443/apis/config.openshift.io/v1/clusteroperators": dial tcp 10.0.89.18:6443: connect: connection refused 
INFO Use the following commands to gather logs from the cluster 
INFO openshift-install gather bootstrap --help    
ERROR Bootstrap failed to complete: Get "https://api.ocp4-apse2-99.lab-aws.ldcloud.com.au:6443/version": dial tcp 10.0.55.20:6443: connect: connection refused 
ERROR Failed waiting for Kubernetes API. This error usually happens when there is a problem on the bootstrap host that prevents creating a temporary control plane. 


Solution
--------
- Looking at Ext LB listeners, all of them are Unhealthy? Why? Could this be an issue?

$ curl -vv https://api.ocp4-apse2-99.lab-aws.ldcloud.com.au:6443
*   Trying 10.0.69.169:6443...
* connect to 10.0.69.169 port 6443 failed: Connection refused
*   Trying 10.0.89.18:6443...
* connect to 10.0.89.18 port 6443 failed: Connection refused
*   Trying 10.0.55.20:6443...
* connect to 10.0.55.20 port 6443 failed: Connection refused
* Failed to connect to api.ocp4-apse2-99.lab-aws.ldcloud.com.au port 6443 after 7 ms: Connection refused
* Closing connection 0
curl: (7) Failed to connect to api.ocp4-apse2-99.lab-aws.ldcloud.com.au port 6443 after 7 ms: Connection refused

# Checkin which IP my EC2 is using as the source of curl.
$ curl ifconfig.me
3.25.167.23

Could this be the reason why I am getting blocked? Sec Grp for Master and Bootstraps 