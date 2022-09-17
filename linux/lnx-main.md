# Linux Principles 
- Everything is a file (Including Hardware)
- Small single purpose programs
- Ability to chain these program together for complex operations
- Avoid captive user interface
- Configuration data is stored in a txt file 

# Why Linux 
- Opensource 
- Community Support 
- Supposrt wide hardwares 
- Customization 
- Most servers run on Linux 
- Automation
- Security 

# Architecture of Linux 

		End User layer
--------------------------------
		SHELL 
--------------------------------
		KERNEL
--------------------------------
    	HARDWARE

# 

# Linux Directory Structure 

					    / 	(ROOT)	
                            |
home 	etc 	var 	usr 	bin 	dev 	sys     tmp     proc    root    sbin
  |	  	|	  	|   	|    	|   	|   	|       |       |       |       |

  
	/ 		"Root"
	/bin 	Binaries and other executable programs 
	/etc 	System configuration files 
	/home 	Home (User) directories
	/opt 	Optional or third party software
	/tmp 	Temp space, typically cleared on reboot 
	/usr	User related programs 
	/mnt 	Used to mount external file systems 
	/var 	Variable data, mostly log files 
	/srv	Contains data which is served by the system E.g. /srv/www or /srv/ftp 
	/sys	Used to display and sometimes configure the devices know to the Linux Kernel
	/export 	Shared file system 
	/lib 	System libraries 
	/lib64 	System libraries 64 bit 
	/media	to mount removable disks 
	/sbin 
	/selinux 

================================================
Home Directories: /root, /home/username 
User Executables: /bin, /usr/bin, /usr/local/bin
System Executables: /sbin, /usr/sbin, /usr/local/sbin 
Other Mountpoints: /media, /mnt
Configurations: /etc 
Temp Files: /tmp 
Kernels and Bootloader: /boot 
Server Data: /var, /srv 
System Information: /proc, /sys 
Shared Libraries: /lib, /usr/lib, /usr/local/lib

=================================================
File Types 
- Regular FIle		touch		Any dir	–	PNG Image data, ASCII Text, RAR archive data, etc
- Directory File	mkdir		Dir	 	d	Directory
- Block Files		fdisk		/dev	b	Block special
- Character Files	mknod		/dev	c	Character special
- Pipe Files		mkfifo		/dev	p	FIFO
- Symbol Link Files	ln			/dev	l	Symbol link to <linkname>
- Socket Files		socket() system call	/dev	s	Socket


## Commands
- ls [ls -ltr /etc/]
- cd 
- pwd 
- cat 	E.g. cat /etc/os-release 
- echo 
- touch [touch devopsfile{1..10}.txt]
- man [man -k calendar or man -k *calendar*]
- exit 
- cp : copy files 
- cp -r : to copy dir 
- mv
- mv *.txt textdir/ 
- rm 
- rm -r
- clear : Ctrl + L clear screen 
- $PATH
- $OLDPWD [cd $OLDPWD]
- mkdir -p dir1/dir2/dir3
- rmdir  - Delets an empy dir
- rm -rf dir1  - Delete dir recursively 
- ls -F list content by types / - dir @ - Link * executeables 
- ls -t -> List files by time 
- ls -r -> Reverse order 
- ls -latr -> Long listing including all files in sorted by time in Descending order 
- ls -R 
- ls --color 
- tree -d 
- tree -C 
- cat> myfile.txt
- cat myfile.txt 
- yum repolist
- yum list installed
- yum grouplist
- tail -10 /var/log/yum.log
- yum history
- yum seach java
- yum search httpd
- rpm -qa | grep httpd
- ps -ef 
- w
- whoami
- whereis sshd
- chgrp wheel sales.data => Change group of a file 
- whoami
- cat /etc/passwd
- head -1 /etc/passwd
- clear
- head -1 /etc/passwd
- grep vagrant /etc/passwd
- cat /etc/passwd
- clear
- cat /etc/group
- clear
- grep vagrant /etc/passwd
- grep vagrant /etc/group
- id vagrant
- clear
- useradd ansible
- useradd jenkins
- useradd aws
- ls /etc/passwd
- ls /etc/group
- id ansible
- groupadd devops
- clear
- usermod -aG devops ansible
- id ansible
- grep devops /etc/group
- vim /etc/group
- id aws
- passwd ansible
- passwd aws
- passwd jenkins
- su - ansible
- last
- who
- yum install lsof -y
- lsof -u vagrant
- lsof -u aws
- userdel aws
- userdel -r jenkins
- groupdel devops
- userdel -r ansible

# Filters and Redirections
- grep Block lnx-main.md
- grep -i CURL *
- grep -iR CURL *
- sudo grep -R SELINUX /etc/* 
- grep -v Block lnx-main.md [Reverse search]
- grep -vi firewall anaconda-ks.cfg
- less anaconda-ks.cfg
- more anaconda-ks.cfg
- head -20 anaconda-ks.cfg
- tail -2 anaconda-ks.cfg
- tail -f /tmp/glances-root.log 
- cut -d: -f1 /etc/passwd
- awk -F':' '{print $1}' /etc/passwd

## Find an replace 
- :%s/coronavirus/covid19/g [in /tmp/samplefile.txt find a word 'coronavirus' and replace it with 'covid19' globally.]
- sed 's/coronavirus/covid19/g' /tmp/samplefile.txt [To print/view the changes]
- sed -i 's/coronavirus/covid19/g' /tmp/samplefile.txt [-i To make the changes]

## I/O Redirection
- uptime > /tmp/sysinfo.txt
- uptime >> /tmp/sysinfo.txt
- uptime > /dev/null [output is not generated]
- cat /dev/null > /tmp/sysinfo.txt
- freeeee -m 2>> /tmp/error.log
- free -m 1>> /tmp//error.log
- freesdsd -m &>> /tmp//error.log
- wc -l /etc/passwd
- ls /etc/ | grep host
- ls /bin | wc -l
- free -m | grep -i mem 
- sudo find /etc/ -name host*

# Linux System administration Commands : 
### How to check the kernel version of a Linux system?
- uname -a [Everything about Kernel and OS ]
  Linux cryptomach 5.11.0-40-generic #44~20.04.2-Ubuntu SMP Tue Oct 26 18:07:44 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux

- uname -v [Kernel Version]
  #44~20.04.2-Ubuntu SMP Tue Oct 26 18:07:44 UTC 2021

- uname -r [Kernel release]
  5.11.0-40-generic

### How to see the current IP address on Linux?
- ifconfig 
- ip addr show 
- ip addr show wlp7s0

### How to check for free disk space in Linux?
- df -ah [df all file system and human readable ]

### How to see if a Linux service is running?
- systemctl status  

### How to check the size of a directory in Linux?
- du -sh aws/

### How to check for open ports in Linux?
- sudo netstat -tulpn
- lsof -i

### How to check Linux process information (CPU usage, memory, user information, etc.)?
- ps aux | grep nginx 
- top 
- htop 

### How to deal with mounts in Linux?
- mount /dev/sda2 /mnt  - To mount a drive 
- mount -> to see what's already mounted 
- less /etc/fstab - include amount on boot 

### Change mode or permission 
- chmod	Change mode command  
-	ugoa 	User category user group other all 
-	+-= 	Add subsctract or set permission 
-	rwx 	Read write execute 

## umask Modes 
	022
	0644
- umask
- umask -S

## Find Commands 
- find / -size +100M
- find /sbin -mtime +10 -mtime -13
- find -name s* -ls
- find . -type d -newer test.txt
- find . -exec file {} \;
- find /lib/modules/$(uname -r) -type f -iname "*.ko"

### How to Install a from a package file 
- Debian based 
	dpkg -i google.chrome.*.deb
- RPM based 
	rpm -ivh google.chrome.*.rpm

## Hardware devices 
- lspci 
- lspci -vvxxx [v -verbose, x - hexadecimal dump ] misbahiving devices 
- lsusb 
- lsmod 
- sudo lshw 

## Install Stress on Linux 
- sudo amazon-linux-extras install epel -y 
- sudo yum install stress -y
- stress -c 4 

# How to curl?
curl https://google.com
curl -v https://google.com
curl -I http://www.example.org
curl -o hello.zip ftp://speedtest.tele2.net/1MB.zip

### glossary 
Remote Repo 
Clone 
Local Repo 
Staging Area 
Pull / Push 
Add / Commit 
Work area 
HEAD will always point to the latest commit 
