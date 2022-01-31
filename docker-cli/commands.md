## Enter the following to install Docker:
sudo yum -y install docker
 
 ## Enter the command below to start Docker as a service:
sudo systemctl start docker
 
## Verify Docker is running by entering:
sudo docker info

## To see a list of the commands in Docker, simply enter:
docker --help

## Enter the following management command:
docker system info

## To see all of the commands grouped under system, enter:
docker system --help

## Enter the following to see how easy it is to get a container running:
docker run hello-world

## Run the ubuntu image in interactive mode:
docker run -it ubuntu /bin/bash 

## Try running a more complex container with some options specified:
docker run --name web-server -d -p 8080:80 nginx:1.12

	This time you specified the tag 1.12 indicating you want version 1.12 of nginx instead of the default latest version. There are three Pull complete messages this time, indicating the image has three layers. The last line is the id of the running container. The meanings of the command options are:

	--name container_name: Label the container container_name. In the command above, the container is labeled web-server. This is much more manageable than the id, 31f2b6715... in the output above.
	-d: Detach the container by running it in the background and print its container id. Without this, the shell would be attached to the running container command and you wouldn't have the shell returned to you to enter more commands.
	-p host_port:container_port: Publish the container's port number container_port to the host's port number host_port. This connects the host's port 8080 to the container port 80 (http) in the nginx command.
	You again used the default command in the image, which runs the web server in this case.

## Verify the web server is running and accessible on the host port of 8080:
curl localhost:8080

## To list all running containers, enter:
docker ps

## Enter the following to see a list of all running and stopped containers:
docker ps -a

## To stop the nginx server, enter:
docker stop web-server

## To start running the command in the web-server container again, enter:
docker start web-server

## To see the container''s output messages, enter:
docker logs web-server
	Docker logs messages written to standard output and standard error. In the case of nginx, it writes a line for each request that it receives.

## You can run other commands in a running container. For example, to get a bash shell in the container enter:
docker exec -it web-server /bin/bash

## To list the files in the container''s /etc/nginx directory, enter:
docker exec web-server ls /etc/nginx

## Stop the nginx container:
docker stop web-server

## Search for an image that you don''t know the exact name of, say an image for Microsoft .NET Core, by entering:
docker search "Microsoft .NET Core"

## images in you local machine
ls -asl /var/lib/docker/

[root@centosdev vagrant]# ls -asl /var/lib/docker/image/overlay2/imagedb/content/sha256/
total 8
0 drwx------. 2 root root  150 Sep 26 09:07 .
0 drwx------. 3 root root   20 Sep 26 09:05 ..
4 -rw-------. 1 root root 1462 Sep 26 09:07 fb52e22af1b01869e23e75089c368a1130fa538946d0411d47f964f8b1076180
4 -rw-------. 1 root root 1469 Sep 26 09:05 feb5d9fea6a5e9606aa995e879d862b825965ba48de054caab5ef356dc6b3412

## Some practical
[root@centosdev vagrant]# docker images
REPOSITORY    TAG       IMAGE ID       CREATED       SIZE
hello-world   latest    feb5d9fea6a5   2 days ago    13.3kB
ubuntu        latest    fb52e22af1b0   3 weeks ago   72.8MB

[root@centosdev vagrant]# docker ps -a
CONTAINER ID   IMAGE         COMMAND       CREATED          STATUS                       PORTS     NAMES
ea7df2c90646   ubuntu        "/bin/bash"   7 minutes ago    Exited (127) 7 minutes ago             optimistic_hugle
f79364e0e615   ubuntu        "/bin/bash"   9 minutes ago    Exited (0) 5 minutes ago               romantic_buck
306c7c0e7652   ubuntu        "/bin/bash"   23 minutes ago   Exited (1) 19 minutes ago              brave_euler
5c6b349ff930   hello-world   "/hello"      25 minutes ago   Exited (0) 25 minutes ago              objective_sutherland

[root@centosdev vagrant]# docker start romantic_buck
romantic_buck

[root@centosdev vagrant]# docker attach romantic_buck
root@f79364e0e615:/# cat home/ajit/container.txt
This only exist in this container


[root@centosdev vagrant]# docker container prune
WARNING! This will remove all stopped containers.
Are you sure you want to continue? [y/N] y
Deleted Containers:
ea7df2c906469461a32e51aac3d288b20800c8c0a68e55fe7269d95187906eaf
f79364e0e61516233e2bedcb422e235facf0eb659e02d49ad6a466cf113f5693
306c7c0e7652d4043854f2bacccc221683abd5801959278deb44fe1d1293f5a2
5c6b349ff93000bebf1821c04b4f71980810991e168a49e81d9cc0108faa8f57

Total reclaimed space: 310B


## Creating a image through dockerfile. 
sudo nano Dockerfile
You will also need your compiled binarys. In my case it a GOLang binary named "hello" 

## Create a Docker image and Run a program 
docker run . 

## Creates and image with the name greeting 
docker run -t greeting . 

cat /var/lib/docker/image/overlay2/imagedb/content/sha256/2712cb1afca47f896dc6adaaf391e82a356aacd0d783e30fcc0f0829a354eb28  | python3 -m json.tool 

## Create an image based on the existing image/container 
- install python3 on the existing ubuntu image and save that images as ubuntu_python
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
[root@centosdev webapp]# ls
Dockerfile  main.go  webapp

#Contents of the Dockerfile 
FROM ubuntu
COPY webapp /
EXPOSE 8080
RUN apt-get update
CMD ["./webapp"]

# Create a go binary & Dockerfile 

[root@centosdev webapp]# docker build -t webapp .
Sending build context to Docker daemon  6.814MB
Step 1/5 : FROM ubuntu
 ---> fb52e22af1b0
Step 2/5 : COPY webapp /
 ---> 9e610ed7cd2e
Step 3/5 : EXPOSE 8080
 ---> Running in ee089cb95c18
Removing intermediate container ee089cb95c18
 ---> 44c7d18f0689
Step 4/5 : RUN apt-get update
 ---> Running in e133f2db169c
Fetched 19.1 MB in 11s (1762 kB/s)
Reading package lists...
Removing intermediate container e133f2db169c
 ---> ddf65e59b8f3
Step 5/5 : CMD ["./webapp"]
 ---> Running in bb8a98141062
Removing intermediate container bb8a98141062
 ---> 64321cf6eaa4
Successfully built 64321cf6eaa4
Successfully tagged webapp:latest

#This will get the docker container running with the webapp in it 
[root@centosdev webapp]# docker run webapp
2021/09/27 09:35:30 Starting application on port 8080
^C

# To run the contain in the background use 
[root@centosdev webapp]# docker run -d webapp
e06516626ec493160eaf95ca7c0b574669e4649ee55cefc1b6f3dd7634c9986c

[root@centosdev webapp]# docker ps -a
CONTAINER ID   IMAGE     COMMAND      CREATED         STATUS                          PORTS      NAMES
e06516626ec4   webapp    "./webapp"   7 seconds ago   Up 6 seconds                    8080/tcp   inspiring_hellman
6d25d01d9a8b   webapp    "./webapp"   2 minutes ago   Exited (2) About a minute ago              flamboyant_khorana

# To get the container info 
[root@centosdev webapp]# docker inspect e06516626ec4

# To get the attach the container  
[root@centosdev webapp]# docker attach e06516626ec4

# To stop the container 
[root@centosdev webapp]# docker stop e06516626ec4
e06516626ec4

#dynamicall publish the web app on a host port 
[root@centosdev webapp]# docker run -d -P webapp
51c68afc13709b1ad691f3c129348f8ccb052855e7bff12e678e4c5e143a3ba9
[root@centosdev webapp]# docker ps -a
CONTAINER ID   IMAGE     COMMAND      CREATED          STATUS                      PORTS                                         NAMES
51c68afc1370   webapp    "./webapp"   8 seconds ago    Up 7 seconds                0.0.0.0:49153->8080/tcp, :::49153->8080/tcp   epic_brattain
e06516626ec4   webapp    "./webapp"   11 minutes ago   Exited (2) 6 minutes ago                                                  inspiring_hellman
6d25d01d9a8b   webapp    "./webapp"   13 minutes ago   Exited (2) 12 minutes ago                                                 flamboyant_khorana
[root@centosdev webapp]# curl localhost:49153
Hello World!

# Specify the port number explicitly in command 
[root@centosdev webapp]# docker run -d -p 3000:8080 webapp

[root@centosdev webapp]# docker ps
CONTAINER ID   IMAGE     COMMAND      CREATED         STATUS         PORTS                                       NAMES
71a04d096a32   webapp    "./webapp"   3 seconds ago   Up 3 seconds   0.0.0.0:3000->8080/tcp, :::3000->8080/tcp   wonderful_bose

#Network types in Docker 
[root@centosdev vagrant]# docker network ls
NETWORK ID     NAME      DRIVER    SCOPE
d4ef1c5e2a0c   bridge    bridge    local
035a5f311e0d   host      host      local
097a28fb4e69   none      null      local

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
[root@centosdev network]# docker run -d --network=host ubuntu_networking /webapp
05128ee3ea91d23e1b11dae84aedb38cc2ccb87617e77dd30126352d638f7b92

[root@centosdev network]# docker ps
CONTAINER ID   IMAGE               COMMAND       CREATED         STATUS         PORTS     NAMES
05128ee3ea91   ubuntu_networking   "/webapp"     6 seconds ago   Up 5 seconds             sweet_williams
73e3a6c0a7d4   ubuntu_networking   "/bin/bash"   4 minutes ago   Up 4 minutes             determined_panini
4cc826557163   ubuntu_networking   "/bin/bash"   5 minutes ago   Up 5 minutes             trusting_zhukovsky
ca66611f3599   ubuntu_networking   "/bin/bash"   6 minutes ago   Up 6 minutes             serene_matsumoto
892aad8b7b7b   ubuntu_networking   "/bin/bash"   8 minutes ago   Up 8 minutes             wizardly_sutherland

# This is as good as working through hostmachine.. The container has the same Ip as of host machine. 
[root@centosdev network]# curl localhost:8080
<h1>This is a GO webapp that works with Docker.</h1>

#Persistent Storage Options in Docker 
Docker provides three options. Which are bind mounts, volumes and in memory option called tmpfs, as in temporary file system.

#Create a docker image that will write to the file 
docker build -t "scratch_volume"

	# a web app developed in go does that trick

#start the image with bind storage specify source and destination 
docker run -d --mount type=bind.src"/var/demo/logs".dst=/logs scratch_volume


## Tagging 