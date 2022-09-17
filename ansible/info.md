# Ansible Installation with AWS 

- Spin a new AWS instance for Ansible Server
- get the packages installed 
- python3, python-pip, virtualenv 
	sudo yum install python-pip openssl 
- create a virtual env 
	python3 -m venv ./myansible 
- Activate the virtual env
	source myansible/bin/activate
- Install ansible inside the virtual env
	sudo amazon-linux-extras install ansible2 -y
- create the config file 
	ansible.cfg 
- created inventory file 
	hosts 
- generated the SSH key on the ansible server 
	ssh-keygen -t rsa 
- imported the key in AWS account i.e ansible-aws-key
- Spin up 2 new ec2 instance, used the same key we imported from ansible server 