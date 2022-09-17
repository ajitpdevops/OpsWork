-- USE Fedora for this demonstration.. 


1. Enter the following to install Docker:
sudo yum -y install docker
 
2. Enter the command below to start Docker as a service:
sudo systemctl start docker
 

3. Verify Docker is running by entering:
sudo docker info

1. To see a list of the commands in Docker, simply enter:
docker --help

2. Enter the following management command:
docker system info

3. To see all of the commands grouped under system, enter:
docker system --help


1. Enter the following to see how easy it is to get a container running:
docker run hello-world

Re-run the same command:
docker run hello-world

3. Try running a more complex container with some options specified:
docker run --name web-server -d -p 8080:80 nginx:1.12

	This time you specified the tag 1.12 indicating you want version 1.12 of nginx instead of the default latest version. There are three Pull complete messages this time, indicating the image has three layers. The last line is the id of the running container. The meanings of the command options are:

	--name container_name: Label the container container_name. In the command above, the container is labeled web-server. This is much more manageable than the id, 31f2b6715... in the output above.
	-d: Detach the container by running it in the background and print its container id. Without this, the shell would be attached to the running container command and you wouldn't have the shell returned to you to enter more commands.
	-p host_port:container_port: Publish the container's port number container_port to the host's port number host_port. This connects the host's port 8080 to the container port 80 (http) in the nginx command.
	You again used the default command in the image, which runs the web server in this case.

4. Verify the web server is running and accessible on the host port of 8080:
curl localhost:8080

5. To list all running containers, enter:
docker ps

6. Enter the following to see a list of all running and stopped containers:
docker ps -a

7. To stop the nginx server, enter:
docker stop web-server

8. Verify the server is no longer running by running:
docker ps

9. To start running the command in the web-server container again, enter:
docker start web-server

10. To see the container''s output messages, enter:
docker logs web-server
	Docker logs messages written to standard output and standard error. In the case of nginx, it writes a line for each request that it receives.

11. You can run other commands in a running container. For example, to get a bash shell in the container enter:
docker exec -it web-server /bin/bash


12. To list the files in the container''s /etc/nginx directory, enter:
docker exec web-server ls /etc/nginx

13. Stop the nginx container:
docker stop web-server

14. Search for an image that you don''t know the exact name of, say an image for Microsoft .NET Core, by entering:
docker search "Microsoft .NET Core"


#Run 

docker exec -it web-server /bin/bash

# Docker Commands 
[root@centosdev vagrant]# docker run hello-world
docker run -it ubuntu /bin/bash 


ls -asl /var/lib/docker/

ls -asl /var/lib/docker/image/overlay2/imagedb/content/sha256/
total 8
0 drwx------. 2 root root  150 Sep 26 09:07 .
0 drwx------. 3 root root   20 Sep 26 09:05 ..
4 -rw-------. 1 root root 1462 Sep 26 09:07 fb52e22af1b01869e23e75089c368a1130fa538946d0411d47f964f8b1076180
4 -rw-------. 1 root root 1469 Sep 26 09:05 feb5d9fea6a5e9606aa995e879d862b825965ba48de054caab5ef356dc6b3412

docker images
REPOSITORY    TAG       IMAGE ID       CREATED       SIZE
hello-world   latest    feb5d9fea6a5   2 days ago    13.3kB
ubuntu        latest    fb52e22af1b0   3 weeks ago   72.8MB


docker start romantic_buck
romantic_buck

docker attach romantic_buck

docker container prune
Total reclaimed space: 310B


Docker 

sudo nano Dockerfile
You will also need your compiled binarys. In my case it a GOLang binary named "hello" 


# Create a Docker image and Run a program 
docker run . 

# Creates and image with the name greeting 
docker run -t greeting . 

cat /var/lib/docker/image/overlay2/imagedb/content/sha256/2712cb1afca47f896dc6adaaf391e82a356aacd0d783e30fcc0f0829a354eb28  | python3 -m json.tool 


# Create an image based on the existing image/container 
# install python3 on the existing ubuntu image and save that images as ubuntu_python

docker run -it ubuntu /bin/bash

Run following commads to install python3 in the docker image 
apt-get update
apt-get install python3 
which python3 
#exit out of the shell

# docker images -> It still contains all the existing images 

docker commit --change='CMD ["python3", "-c", "import this"]' f0c1562f9a96 ubuntu_python
#change flag opens the image with the specified python command 

#Now view the docker images 
[root@centosdev hello]# docker images
REPOSITORY      TAG       IMAGE ID       CREATED          SIZE
ubuntu_python   latest    2e71f8cfd053   6 seconds ago    142MB
greeting        latest    2712cb1afca4   25 minutes ago   2.03MB
hello-world     latest    feb5d9fea6a5   3 days ago       13.3kB
ubuntu          latest    fb52e22af1b0   3 weeks ago      72.8MB

# Now run the docker image, it runs the python commands to print the Zen of python. 
[root@centosdev hello]# docker run ubuntu_python
The Zen of Python, by Tim Peters
...

# Run a go web-app on docker ubuntu 
ls
Dockerfile  main.go  webapp

#Contents of the Dockerfile 
FROM ubuntu
COPY webapp /
EXPOSE 8080
RUN apt-get update
CMD ["./webapp"]

# Create a go binary & Dockerfile 

docker build -t webapp .


#This will get the docker container running with the webapp in it 
docker run webapp
2021/09/27 09:35:30 Starting application on port 8080
^C

# To run the contain in the background use 
docker run -d webapp
e06516626ec493160eaf95ca7c0b574669e4649ee55cefc1b6f3dd7634c9986c

docker ps -a
CONTAINER ID   IMAGE     COMMAND      CREATED         STATUS                          PORTS      NAMES
e06516626ec4   webapp    "./webapp"   7 seconds ago   Up 6 seconds                    8080/tcp   inspiring_hellman
6d25d01d9a8b   webapp    "./webapp"   2 minutes ago   Exited (2) About a minute ago              flamboyant_khorana

# To get the container info 
docker inspect e06516626ec4

# To get the attach the container  
docker attach e06516626ec4

# To stop the container 
docker stop e06516626ec4
e06516626ec4

#dynamicall publish the web app on a host port 
docker run -d -P webapp
docker ps -a


# Specify the port number explicitly in command 
docker run -d -p 3000:8080 webapp

docker ps

#Network types in Docker 
docker network ls

# Networking in Docker 
docker run -it ubuntu_networking
	#this takes us directly into the container shell.
	ip addr show
	#create couple more containers and run the following command from any image 
	root@73e3a6c0a7d4:/# arp-scan --interface=eth0 --localnet
	Interface: eth0, datalink type: EN10MB (Ethernet)
	Starting arp-scan 1.8.1 with 65536 hosts (http://www.nta-monitor.com/tools/arp-scan/)
	172.17.0.1      02:42:06:de:f3:85       (Unknown)
	172.17.0.2      02:42:ac:11:00:02       (Unknown)
	172.17.0.3      02:42:ac:11:00:03       (Unknown)
	172.17.0.4      02:42:ac:11:00:04       (Unknown)

#Now create a container with host network type like below 
docker run -d --network=host ubuntu_networking /webapp

[root@centosdev network]# docker ps

# This is as good as working through hostmachine.. The container has the same Ip as of host machine. 
curl localhost:8080


#Persistent Storage Options in Docker 
Docker provides three options. Which are bind mounts, volumes and in memory option called tmpfs, as in temporary file system.

#Create a docker image that will write to the file 
docker build -t "scratch_volume"

# a web app developed in go does that trick

#start the image with bind storage specify source and destination 
docker run -d --mount type=bind.src"/var/demo/logs".dst=/logs scratch_volume
