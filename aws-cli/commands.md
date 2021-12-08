ec2 profiles
Use credentials using environment variables
.aws dir in the home location

aws s3 ls
aws ec2 describe-instaces
aws ec2 describe-security-groups
aws ec2 describe-images
aws ec2 create-key-pair --key-name MyKeypair --query 'KeyMaterial' --output text > MyLinuxKeyPair.pem
aws ec2 describe-key-pairs
aws ec2 run-instances --image-id ami-041d6256ed0f2061c --count 1 --instance-type t2.micro --key-name MyKeyPair
	Examples : - 
		aws ec2 run-instances --image-id ami-xxxxxxxx --count 1 --instance-type t2.micro --key-name MyKeyPair --security-group-ids sg-903004f8 --subnet-id subnet-6e7f829e
		aws ec2 run-instances --image-id ami-173d747e --count 1 --instance-type t1.micro --key-name MyKeyPair --security-groups my-sg

aws ec2 describe-instances --filters "Name=instance-type,Values=t2.micro"
aws ec2 describe-instances --filters "Name=instance-type,Values=t2.micro" --query "Reservations[].Instances[].InstanceId"
aws ec2 terminate-instances --instance-ids i-0c68bc94ccb335fd0



#!/bin/bash
yum install -y perl-Switch perl-DateTime perl-Sys-Syslog perl-LWP-Protocol-https perl-Digest-SHA.x86_64
wget http://aws-cloudwatch.s3.amazonaws.com/downloads/CloudWatchMonitoringScripts-1.2.2.zip
unzip CloudWatchMonitoringScripts-1.2.2.zip
rm CloudWatchMonitoringScripts-1.2.2.zip
echo "*/1 * * * * /aws-scripts-mon/mon-put-instance-data.pl --mem-util --disk-space-util --disk-path=/ --from-cron" > monitoring.txt
crontab monitoring.txt
rm monitoring.txt
