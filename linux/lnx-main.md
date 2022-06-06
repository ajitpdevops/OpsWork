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


## Commands
- ls 
- cd 
- pwd 
- cat 
- echo 
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
- yum list installed

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

## Repository
cd /etc/yum.repos.d
ls 



