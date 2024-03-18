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