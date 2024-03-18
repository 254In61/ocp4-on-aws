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
