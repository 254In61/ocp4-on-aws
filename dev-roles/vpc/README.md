Overview
========
=> Role has tasks that build vpc on AWS

Design
======
- I would have loved to use Terraform to do this but I chose to go with already created cloudformation template by Red Hat team.
- Why? Because they already defined what outputs I can pick from the Cloudformation stack for the next steps of infra build.

How to run?
===========
- Set your environmental variables as details in the main README.md of this repo.
- Run $ansible-playbook vpc.yml