Building
========
=> Ensure you have IAM role with SSM permissions.

=> Build the EC2 either on console or you can use whichever IAC you fancy.

Preparing Jump Server
====================
1. SSH into the EC2. ** I like connecting straight on my console, Session Manager **

2. Clone the repo : $ cd $HOME && git clone -b develop https://github.com/254In61/ocpv4-on-aws.git

3. Prepare the EC2 Linux environment: $  chmod +x scripts/ec2-env-prep.sh && scripts/ec2-env-prep.sh

4. 