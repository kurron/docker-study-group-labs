# Overview
This document contains the steps that were covered in the
[Docker 101](https://classroom.google.com/c/NTk3MDEyOTcxM1pa) labs.
Useful if you missed a class or forgot a step.

# Prerequisites
* An AWS account
* An SSH client, [OpenSSH](https://www.openssh.com/) preferred
* Basic Linux knowledge preferred

# Tmux Cheat Sheet
* `ctrl-b C` -- create new window
* `ctrl-b n` -- jump to next window
* `ctrl-b p` -- jump to previous window
* `ctrl-b 0` -- jump to 0th window
* `ctrl-b ""` -- split window horizontally (pane)
* `ctrl-b O` -- jump to next pane
* `ctrl-b x` -- close pane

# Lab 1: Installation

## Ubuntu Linux (manual)
1. Spin up a small EC2 instance using the Ubuntu Linux AMI
1. `uname -a` to verify we are running a Linux 3.1.0 or higher kernel
1. `sudo apt-get install apt-transport-https ca-certificates curl software-properties-common`
1. `curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -`
1. `sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"`
1. `sudo apt-get update`
1. `sudo apt-get install docker-ce`
1. `sudo docker info`
1. destroy the instance

## Ubuntu Linux (automated)
1. Spin up a small EC2 instance using the Ubuntu Linux AMI
1. `uname -a` to verify we are running a Linux 3.1.0 or higher kernel
1. `sudo apt-get update`
1. `whereis curl`
1. `sudo apt-get install curl`
1. `curl https://get.docker.com/ | sudo sh`
1. `sudo docker info`
1. `docker info`
1. `sudo usermod -aG docker ubuntu`
1. `docker info`
1. log out and back in again
1. `docker info`
1. save the instance (we'll be using it in future labs)

# Lab 2: Kicking The Tires
1. Spin up a Ubuntu EC2 instance with Docker installed
1. ~~`sudo status docker`~~
1. ~~`status docker`~~
1. `cat /etc/group`
1. `docker info`
1. `sudo service docker stop`
1. `sudo service docker start`
1. `docker help`
1. `man docker`
1. `docker help run`
1. `docker run --help`
1. `docker run --interactive --tty ubuntu /bin/bash`
1. start a second ssh session to your EC2 instance (`tmux` can simplify this)
1. compare results of commands from inside Docker and on the EC2 instance
  1. `whoami`
  1. `hostname`
  1. `cat /etc/hosts`
  1. `hostname --all-ip-addresses`
  1. `ps -aux`
  1. `uname -a`
  1. `top`
  1. `ls /bin`
  1. `sudo find / -type d | wc --lines` -- **no `sudo`** needed on the Docker side
  1. `cat /proc/cpuinfo`
  1. `cat /proc/meminfo`
  1. `cat /proc/net/dev`
1. in your Docker container, `apt-get update; apt-get install vim`
1. in your Docker container, `exit`

# Lab 3: Manipulating Containers
. `docker ps` -- show running containers
1. `docker ps --all` -- show all containers
1. `docker ps --latest` -- show the last running container
1. `docker run --name wolverine --interactive --tty ubuntu /bin/bash`
1. `exit` the container
1. `docker ps --latest` -- notice the container name
1. `docker start wolverine` -- start stopped container
1. `docker ps` -- should see the wolverine container running
1. `docker attach <container id>` -- see how few characters you can get away with
1. `exit` to stop the container

# Lab 4: Manipulating Containers (continued)
1. `docker run --detach --name nightcrawler ubuntu /bin/sh -c "while true; do echo hello world; sleep 2; done"`
1. `docker logs --follow --timestamps nightcrawler`
1. `docker top nightcrawler`
1. `docker stats nightcrawler`
1. `docker exec --detach nightcrawler touch /etc/new_config_file`
1. `docker exec --interactive --tty nightcrawler /bin/bash`
1. `ls -alh /etc/new_config_file` -- should see the file added previously
1. `exit`
1. `docker stop nightcrawler`
1. `docker ps -a` -- container still exists but is not running
1. `docker run --restart=always --detach --name banshee ubuntu /bin/sh -c "sleep 2; exit 1964"`
1. `watch docker ps` -- notice how the container keeps restarting after the "failure"
1. `docker stop banshee`
1. `docker run --restart=on-failure:5 --detach --name colossus ubuntu /bin/sh -c "sleep 5; exit 1964"`
1. `watch docker ps` -- notice how Docker gives up restarting after 5 tries
1. `docker inspect colossus`
1. `docker inspect --format='{{ .State.Running }}' colossus`
1. `docker stop colossus`
1. `docker rm colossus`
1. clean up the remaining containers on your own. Try using id and names.
1. `docker rm --volumes --force $(docker ps --all --quiet)` -- shell magic to nuke all containers

# Lab 5: Docker Repository
1. visit `https://hub.docker.com/`
1. create an account (we'll use it in later labs)
1. click the `Explore` link
1. browse through the images marked as *official*
1. poke around the following images looking for differences between them
1. `docker run --interactive --tty alpine /bin/bash`
1. `docker run --interactive --tty centos /bin/bash`
1. `docker run --interactive --tty amazonlinux /bin/bash`
1. `docker run --interactive --tty bash /bin/bash`
1. `docker run --interactive --tty clearlinux /bin/bash`

# Lab 6: Docker Images
1. `docker images`
1. `docker run --interactive --tty ubuntu:16.04`
1. `docker run --interactive --tty ubuntu:14.04`
1. `docker run --interactive --tty ubuntu:latest`
1. `docker pull ubuntu:12.04`
1. `docker images`
1. `docker search python`
1. `docker search kurron`
1. `docker run --interactive --tty kurron/docker-azul-jdk-8-build /bin/bash`
1. `java -version`
1. `ansible --version`
1. `docker --version`
1. `exit`
1. `docker images`
1. `docker rmi --force $(docker images --quiet)`
1. `docker images`

# Lab 7: Creating Docker Images (the hard way)
1. `docker run --interactive --tty ubuntu:latest`
1. `apt-get update`
1. `apt-get install apache2`
1. `exit`
1. `LAST=$(docker ps --latest --quiet)`
1. `echo ${LAST}`
1. `docker commit ${LAST} kurron/apache2` <--- use your own repository account
1. `docker images kurron/apache2`
1. `docker commit --message "Created by hand" --author "Ron Kurr kurron@jvmguy.com" ${LAST} kurron/apache2:by-hand`
1. `docker inspect kurron/apache2:by-hand`
1. `docker run --interactive --tty kurron/apache2:by-hand`
1. `service apache2 status`

# Lab 8: Creating Docker Images (an easier way)
1. `git clone https://github.com/kurron/docker-study-group-labs.git`
1. `cd docker-study-group-labs/solutions/lab-07`
1. `docker build --tag="kurron/static_web:v1.0.0" .`
1. `docker images`
1. `docker build --file Dockerfile.broken .`
1. `docker build --no-cache --tag="kurron/static_web:v1.0.0" .`
1. `docker history 85098924c514` <--- your image id will be different

# Lab 9: Fun With Port Bindings
1. `docker run --detach --publish 80 --name domino kurron/static_web:v1.0.0 nginx -g "daemon off;"`
1. `docker ps --latest`
1. `docker port cb888707fcba`
1. `docker port domino 80`
1. `docker run --detach --publish 80:80 --name domino kurron/static_web:v1.0.0 nginx -g "daemon off;"`
1. `docker run --detach --publish 8080:80 --name domino kurron/static_web:v1.0.0 nginx -g "daemon off;"`
1. `docker run --detach --publish 127.0.0.1:8080:80 --name domino kurron/static_web:v1.0.0 nginx -g "daemon off;"`
1. `docker run --detach --publish 127.0.0.1::80 --name domino kurron/static_web:v1.0.0 nginx -g "daemon off;"`
1. stop and remove all containers
1. `docker run --detach --publish-all --name domino kurron/static_web:v1.0.0 nginx -g "daemon off;"`
1. `docker port domino`
1. `curl localhost:32769` <--- your port will be different

# Lab 10: Dockerfile Madness
1. `cd solutions/lab-10`
1. `docker build --tag="kurron/dockerfile-example:v1.0.0" .`
1. `docker run --interactive --tty kurron/dockerfile-example:v1.0.0`
1. `docker run --interactive --tty kurron/dockerfile-example:v1.0.0 -alh /opt`
1. `docker run --interactive --tty kurron/dockerfile-example:v1.0.0 -alh /opt/wordpress`
1. `docker images`
1. `docker inspect kurron/dockerfile-example:v1.0.0`

# Lab 11: Publishing Docker Images
1. `cd labs/lab-11`
1. edit the `Dockerfile` and `local.txt` files, using your personal settings
1. `docker build --tag="kurron/publish-example:v1.0.0" .` <--- use your own account
1. `docker run --interactive --tty kurron/publish-example:v1.0.0`
1. `docker push kurron/publish-example:v1.0.0`
1. `docker login`
1. `docker push kurron/publish-example:v1.0.0`
1. visit [https://hub.docker.com/](https://hub.docker.com/) and find your image
1. run somebody else's image, illustrating how image sharing works

# Lab 12: Automated Image Building
This is difficult to explain in text so try and be in class for this one.

1. Create a [GitHub](https://github.com/) account if you don't already have one
1. Create a new repository using the `labs/lab-11` folder as source
1. Log into your [Docker Hub](https://hub.docker.com) account
1. click `Create -> Create Automated Build`
1. `Add Repository`
1. Add your GitHub account
1. Select your repository
1. `Create` to create the build project
1. Verify that the build was successful
1. Checkout your GitHub project
1. Make an edit to your `local.txt`
1. `git commit -am 'Ron made me do this'`
1. `git push`
1. In the Docker Hub console, make sure your Docker build gets triggered
1. Pull down the latest image and run it, ensuring your changes show up

# Lab 13: Simple Volume Mount
1. `cd docker-study-group-labs`
1. `git reset --hard` <--- will nuke any local changes you may have made
1. `git pull` to get the current bits
1. `cd solutions/lab-12`
1. `docker build --tag="kurron/mount-example:v1.0.0" .` <--- use your own account
1. `docker history kurron/mount-example:v1.0.0`
1. `docker run --detach --publish 80 --name mystique --volume ${PWD}/website:/var/www/html/website:ro kurron/mount-example:v1.0.0 nginx`
1. `docker port mystique`
1. `curl --silent localhost:32771` <--- your port will be different
1. edit `website/index.html`
1. `curl --silent localhost:32771`
1. determine the public address of your EC2 instance
1. open your web browser to `http://ec2-instance-address:32771/`
1. **Tip:** Volumes can also be shared between containers and can persist even when containers are stopped
1. **Tip:** If the container directory doesn't exist Docker will create it.

# Lab 14: Networking (single host setup)
1. stop any running containers
1. `docker rm --volumes --force $(docker ps --all --quiet)`
1. `docker rmi --force $(docker images --quiet)`
1. `docker run --name thor --detach --publish-all redis:latest`
1. `docker port thor`
1. `sudo apt-get install redis-tools`
1. `redis-cli -h 127.0.0.1 -p 32769 ping` <--- use your own port
1. `docker run --name sif --interactive --tty --rm redis:latest redis-cli ping` <-- will fail with a connection error

# Lab 15: Networking (Docker Internal Networking)
1. Every Docker container is assigned an IP address, provided through an interface created when we installed Docker. That interface is called `docker0`.
1. `ip a show docker0` (you may have to install the `iproute2` package)
1. The `docker0` interface is a virtual Ethernet bridge that connects our containers and the local host network.
1. `ip a show` -- for every container there is a `veth` interface
1. `docker run --interactive --tty --rm ubuntu:latest bash`
1. `apt-get update && apt-get install iproute2 traceroute`
1. `ip a show eth0` -- we can see the EC2-side ip address of the container
1. `traceroute google.com` -- notice how we go through the `docker0` ip address?
1. `exit`
1. `sudo iptables --table nat --list --numeric` -- this is just to underscore that NAT is happening
1. `docker inspect thor` or `docker inspect --format '{{ .NetworkSettings.IPAddress }}' thor` to get the ip address
1. `redis-cli -h 172.17.0.2 ping` <--- use your own ip, notice we no longer have to specify a port
1. `DNAT       tcp  --  0.0.0.0/0            0.0.0.0/0            tcp dpt:32769 to:172.17.0.2:6379` show the NATing going on
1. `docker inspect --format '{{ .NetworkSettings.IPAddress }}' thor` -- remember this value
1. `docker restart thor`
1. `docker inspect --format '{{ .NetworkSettings.IPAddress }}' thor` -- address can change on you
1. **TIP:** hard coding addresses and the fact that addresses can change make internal networking difficult to use in production

# Lab 16: Networking (Docker Networking)
1. stop any running containers
1. `docker rm --volumes --force $(docker ps --all --quiet)`
1. `docker rmi --force $(docker images --quiet)`
1. `docker network create asgard`
1. `docker network inspect asgard`
1. **TIP:** in addition to bridge networks, which exist on a single host, we can also create overlay networks, which allow us to span multiple hosts.
1. `docker network ls`
1. **TIP:** `docker network rm` will remove a network
1. `docker run --name thor --net asgard --detach --publish-all redis:latest`
1. `docker network inspect asgard` -- notice how `thor` is now a member of the network?
1. `docker run --name sif --net asgard --interactive --tty --rm redis:latest redis-cli -h thor ping` <-- this now works!
1. `docker run --name heimdall --net asgard --interactive --tty --rm ubuntu:latest /bin/bash`
1. `apt-get update && apt-get install dnsutils iputils-ping`
1. `nslookup thor`
1. `ping thor.asgard` -- the network name becomes the domain name
1. `ctrl-c` then `exit`
1. `docker run --name hogun --detach --publish-all redis:latest`
1. `docker network inspect asgard` -- notice how `hogun` is not a member of the network?
1. `docker network connect asgard hogun`
1. `docker network inspect asgard` -- notice how `hogun` is now a member of the network?
1. recreate `heimdall` and use him to see `hogun`
1. `docker network disconnect asgard hogun` to remove `hogun` from the network

# Lab 17: Docker Inside Docker...Whaaaaat?
1. `cd solutions/lab-17`
1. `./clean-slate-protocol.sh`
1. `cat Dockerfile`
1. `docker build --tag="kurron/docker-in-docker:latest" .`
1. `docker run --rm kurron/docker-in-docker:latest`
1. `docker run --interactive --tty --rm --workdir /work-area --volume ${PWD}:/work-area:ro kurron/docker-in-docker:latest bash`
1. `docker build --tag="kurron/docker-in-docker:latest" .` <--- why does this fail?
1. `exit`
1. `docker run --interactive --tty --rm --workdir /work-area --volume /var/run/docker.sock:/var/run/docker.sock --volume ${PWD}/Dockerfile-CentOS:/work-area/Dockerfile:ro kurron/docker-in-docker:latest bash`
1. `cat Dockerfile`
1. `docker build --tag="kurron/docker-in-docker:CentOS" .`
1. `docker images` <-- notice the newly build CentOS images
1. `docker run --rm kurron/docker-in-docker:CentOS`
1. `docker run --interactive --tty --rm --cidfile=/tmp/containerid.txt kurron/docker-in-docker:CentOS bash` <-- you just started a Docker container from within a Docker container!
1. `exit` <-- leave the CentOS container
1. `cat /tmp/containerid.txt` <-- holds the id of the container we just exited
1. `exit` <-- leave the docker-in-docker container
1. **Tip:** use `docker wait <container id>` to wait for a long running container to exit, obtaining its exit code
1. **Tip:** [Drone](https://drone.io/) is a Docker-in-Docker build engine
1. **Tip:** [Shippable](https://www.shippable.com/) is a CI/CD SaaS that supports Docker

# Lab 18: Application Configuration, Docker Style
1. `cd solutions/lab-18`
1. `./clean-slate-protocol.sh`
1. `docker run --interactive --tty --rm --workdir /work-area --volume ${PWD}/config.ini:/work-area/config.ini:ro ubuntu:latest bash`
1. `cat config.ini`
1. `exit`
1. `docker run --interactive --tty --rm  --env username=logan --env password=Weapon-X ubuntu:latest bash`
1. `env | sort`
1. `exit`
1. `docker run --interactive --tty --rm  --env-file config.ini ubuntu:latest bash`
1. `env | sort`
1. `exit`

# Lab 19: More Fun With Volumes
1. `cd solutions/lab-19`
1. `./clean-slate-protocol.sh`
1. `cat nginx/Dockerfile`
1. `docker build --tag="study-group/nginx:latest" nginx`
1. `cat new-england/Dockerfile`
1. `docker build --tag="study-group/new-england:latest" new-england`
1. `cat miami/Dockerfile`
1. `docker build --tag="study-group/miami:latest" miami`
1. `docker images`
1. `docker run --name new-england study-group/new-england:latest`
1. `docker run --name miami study-group/miami:latest`
1. `docker run --name superbowl --detach --publish-all --volumes-from new-england:ro study-group/nginx:latest nginx`
1. `docker ps` <-- notice how only the `superbowl` container is running
1. `IP=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' superbowl)`
1. `curl --silent ${IP}`
1. `docker stop superbowl`
1. `docker rm superbowl`
1. `docker run --name superbowl --detach --publish-all --volumes-from miami:ro study-group/nginx:latest nginx`
1. `IP=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' superbowl)`
1. `curl --silent ${IP}`
1. `docker inspect -f "{{ range .Mounts }}{{.}}{{end}}" superbowl`
1. `docker inspect -f "{{ range .Mounts }}{{.}}{{end}}" miami`
1. `docker inspect -f "{{ range .Mounts }}{{.}}{{end}}" new-england`
1. use `ls` and `cat` to poke around those folders (need to use `sudo`)
1. `docker run --rm --volumes-from new-england:ro --volume $(pwd):/backup:rw ubuntu tar cvf /backup/backup.tar /var/www/html`
1. `tar --list --verbose --file backup.tar`
1. Volume Bullet Points
  - Volumes can be shared and reused between containers
  - A container doesn't have to be running to share its volumes
  - Changes to a volume are made directly
  - Changes to a volume will not be included when you update an image
  - Volumes persist even when no containers use them

# Lab 20: Docker Compose
1. `cd solutions/lab-20`
1. `./clean-slate-protocol.sh`
1. `cat install-docker-compose.sh`
1. `./install-docker-compose.sh`
1. `less docker-compose.yml`
1. `docker-compose config`
1. `docker-compose pull`
1. `docker-compose images`
1. `docker-compose up -d`
1. `docker-compose ps`
1. `docker-compose top`
1. `docker-compose logs`
1. `docker volume ls`
1. `docker volume inspect lab20_mongodb-data`
1. `docker-compose up -d`
1. `docker-compose ps`
1. `docker-compose port showcase 8080`
1. `curl --silent localhost:32811/operations/health | python -m json.tool` <--- use the correct port
1. `curl --silent localhost:32811/operations/info | python -m json.tool` <--- use the correct port
1. `docker-compose down --rmi all --volumes --remove-orphans`

# Lab 21: Docker Machine
Docker Machine is a tool that lets you install Docker Engine on virtual hosts, and manage the hosts with docker-machine commands. You can use Machine to create Docker hosts on your local Mac or Windows box, on your company network, in your data center, or on cloud providers like Azure, AWS, or Digital Ocean.

1. `git reset --hard`
1. `cd solutions/lab-21`
1. `./clean-slate-protocol.sh`
1. `./install-docker-machine.sh`
1. `docker-machine --help`
1. `docker-machine create --help`
1. `cat fix-ssh-key-permissions.sh`
1. `./fix-ssh-key-permissions.sh`
1. `cat create-docker-machine.sh`
1. `cat create-alpha-machine.sh`
1. `./create-alpha-machine.sh us-east-1 a`
1. `./create-bravo-machine.sh us-east-1 a`
1. `./create-charlie-machine.sh us-east-1 a`
1. `./create-delta-machine.sh us-east-1 a`
1. `./create-echo-machine.sh us-east-1 a`
1. `cat fix-docker-permissions.sh`
1. `./fix-docker-permissions.sh <alpha ip>`
1. `./fix-docker-permissions.sh <bravo ip>`
1. `./fix-docker-permissions.sh <charlie ip>`
1. `./fix-docker-permissions.sh <delta ip>`
1. `./fix-docker-permissions.sh <echo ip>`
1. `docker-machine ls`
1. `docker-machine inspect alpha`
1. `docker-machine ip bravo`
1. `docker-machine ssh charlie hostname`
1. `docker-machine scp fix-ssh-key-permissions.sh delta:/tmp`
1. `docker-machine url echo`
1. `docker-machine ls`
1. `docker-machine stop charlie`
1. `docker-machine ls`
1. examine the EC2 console to see the status of the charlie instance
1. `docker-machine start charlie`
1. `docker-machine ls` <-- what is it complaining about and why?
1. `docker-machine regenerate-certs charlie`
1. `docker-machine ls`
1. `docker-machine status delta`
1. `docker-machine restart echo`
1. `docker-machine ls`
1. `docker-machine version alpha`
1. `docker-machine upgrade alpha`
1. `docker-machine rm alpha`
1. See if alpha is in the EC2 console
1. `docker-machine stop bravo charlie delta echo`

# Lab 22: Docker Swarm (creation)
A swarm is a cluster of Docker Engines where you deploy services. The Docker Engine CLI includes the commands for swarm management, such as adding and removing nodes. The CLI also includes the commands you need to deploy services to the swarm and manage service orchestration. A node is an instance of the Docker Engine participating in the swarm.

1. `git reset --hard`
1. `cd solutions/lab-22`
1. `./clean-slate-protocol.sh`
1. `docker-machine start bravo charlie delta echo`
1. `docker-machine ls`
1. `docker-machine regenerate-certs bravo charlie delta echo`
1. `docker-machine ls`
1. In the EC2 console, adjust the security group to allow ingress on ports 22, 2376, 2377, 3376, 7946 (tcp and udp), 4789(udp)
1. `cat create-swarm.sh`
1. `./create-swarm.sh`

# Lab 23: Docker Swarm (network creation)
As of Docker 1.9.0, the ability to create a network specific to a set of containers was added.  There are couple forms of Docker networking but we'll be focusing on overlay networking, aka multi-host networking.  Based on Virtual Extensible LAN (VXLAN) technology, an overlay network gives each container participating in the network its own ip address.  The address is only routable to containers participating in the network.  Since each container gets its own address, you won't get port collisions and you don't have to play the "port mapping game" to find an open port to bind your service to.  Containers can participate in multiple networks so you have the ability to segregate parts of your architecture and still route traffic to where it needs to go.  Finally, networks created on the Swarm manager node are automatically made available to the Swarm workers.  There is a legacy networking mode that required a dedicated consensus server so if you see instructions requiring Consul or etcd to be installed, it is probably dealing with the legacy stuff.

1. `git reset --hard`
1. `cd solutions/lab-23`
1. `./clean-slate-protocol.sh`
1. `cat create-network.sh`
1. `./create-network.sh`

# Lab 24: Docker Swarm (Global Services)
Swarm supports two types of services.  One type, the Global Service, is a container that is targeted to all nodes in the swarm.  So, if you have 10 nodes in your swarm, then all 10 will contain the global services you have deployed.  The second type, the Replicated Service, is a container that is targeted to a specific deployment count.  For example, if I have a stateless web application and I specify a replication of 3, then 3 out of my 10 containers will be running an instance of the web application
![Swarm Diagram](https://docs.docker.com/engine/swarm/images/replicated-vs-global.png)

1. `git reset --hard`
1. `cd solutions/lab-24`
1. `./clean-slate-protocol.sh`
1. `cat create-global-service.sh`
1. `./create-global-service.sh`

Notice all the nodes, including the manager node, now have hello-global service running on them?  If I were to add another node to the swarm, it would also get told to run the service.  When would you want to use a global service?  I use them for "bookkeeping" type of containers such as DataDog or Consul.

# Lab 25: Docker Swarm (Replicated Services)
Last time, we talked about global services.  Today we'll look at replicated services.  As the name suggests, the desire is to have multiple copies of a container running in the cluster.  Containers housing stateless applications, such as a static web site, are candidates for replication.  Containers that rely on local state will not work properly as a replicated service due to migration and load balancing issues.   So what is a replicated service? If you need multiple containers to be running, probably for availability reasons, you can easily tell Docker that you would like N number of containers running at all times.

1. `git reset --hard`
1. `cd solutions/lab-25`
1. `./clean-slate-protocol.sh`
1. `cat create-replicated-service.sh`
1. `./create-replicated-service.sh`

In the above example, we told Docker to deploy 2 copies of the alpine container into the cluster.  We don't care what nodes are running the containers, just as long as there are two of them.  If possible, Docker will schedule the containers on separate hosts.  If a container fails, then it will be replaced.  Very straightforward.  Next time, we'll showcase constrained services which give us a bit more control over the placement of our containers.

# Lab 26: Docker Swarm (Constrained Services)
Last time, we looked at replicated services.  Today we'll look at a nuanced version of replicated services: constrained services.  The primary difference between a replicated service and a constrained one is that we can put restrictions on where the containers can be run.  The simplest constraint is to put containers on nodes that have been tagged with a particular label.  You can also use other placement criteria using simple boolean expressions but the currently available selection attributes are more limited than what you'll find in other schedulers, such a Kubernetes or Nomad.

1. `git reset --hard`
1. `cd solutions/lab-26`
1. `./clean-slate-protocol.sh`
1. `cat create-constrained-service.sh`
1. `./create-constrained-service.sh`

In this example, we are asking to have our 3 alpine containers to only run on worker nodes and Docker will do its best to comply.  If there are no nodes tagged as being workers, Docker will wait until one becomes available and start the containers.  Next time, we'll learn how to scale down our running services.

# Lab 27: Docker Swarm (Scale Down)
Last time, we looked at constrained deployments.  Today we'll see how to scale our services down.  In truth, there really isn't much to do because Docker takes care of everything for us.  All we need to do is to tell the swarm how many instances we need currently.

1. `git reset --hard`
1. `cd solutions/lab-27`
1. `./clean-slate-protocol.sh`
1. `cat scale-down-service.sh`
1. `./scale-down-service.sh`

As you can see, we are telling Docker to scale back our hello-constrained service down to a single instance.  The interesting part of this example is that we can see that the swarm is turning off instances on nodes, leaving us with the single instance.  Again, this is an example of declarative operations.  We're telling Docker **what** we want, **not how to do it**.

# Lab 28: Docker Swarm (Removal)
Last time, we looked at how to scale down our services.  Today, we'll look at how to remove them all together.

1. `git reset --hard`
1. `cd solutions/lab-28`
1. `./clean-slate-protocol.sh`
1. `cat remove-service.sh`
1. `./remove-service.sh`

As you can see, removing a service is very straight forward and is simple as removing a file in Linux.

# Lab 29: Docker Swarm (Upgrade)
Last time, we saw how simple it was to remove a service from the swarm.  Today, we'll look at something a little more interesting: rolling upgrades.  The scenario is this, you have an existing collection of services deployed and you need to upgrade them to current bits.  You would love for the service to remain available during the upgrade process and avoid making your customers unhappy.  How can this be done?  The answer is Docker's rolling upgrades.  The idea is simple, once the process is started, one by one a service in the swarm gets replaced with a newer version.  During the process, you will have a mixture of the new and old bits so your solution cannot be sensitive to that fact.  Lets see how this looks in practice.

1. `git reset --hard`
1. `cd solutions/lab-29`
1. `./clean-slate-protocol.sh`
1. `cat upgrade-service.sh`
1. `./upgrade-service.sh`

In this simple example, we install version 3.0.6 of Redis into the swarm and later decide to upgrade Redis 3.0.7.  This example is contrived and doesn't incorporate things you might do in a real setting, such as monitoring of the state of the containers as they transition or what to do if there is a problem during the replacement process.

# Lab 30: Docker Swarm (Maintenance)
Last time, we looked at rolling upgrades.  Today, we'll learn how to temporarily take a node off-line for maintenance. At some point, you are probably going to have turn your node off and perform some maintenance on the box it is running on.  It could be a simple as upgrading the version of Docker or as complex as swapping out a drive.  During that time, you want to tell the Swarm that the node is temporarily going away and that some other node needs to take its place in the interim.  Thankfully, the process is pretty simple.

1. `git reset --hard`
1. `cd solutions/lab-30`
1. `./clean-slate-protocol.sh`
1. `cat maintenance-mode.sh`
1. `./maintenance-mode.sh`

Things to note in the above session. First, the work shifts from delta to echo.  Second, once we bring delta back on-line the work remains with echo: no rebalancing of the work occurs.

# Lab 31: Docker Swarm (Service Mesh)
>Docker Engine swarm mode makes it easy to publish ports for services to make them available to resources outside the swarm. All nodes participate in an ingress routing mesh. The routing mesh enables each node in the swarm to accept connections on published ports for any service running in the swarm, even if there’s no task running on the node. The routing mesh routes all incoming requests to published ports on available nodes to an active container.

![Service Mesh Diagram](https://docs.docker.com/engine/swarm/images/ingress-routing-mesh.png)

1. `git reset --hard`
1. `cd solutions/lab-31`
1. `./clean-slate-protocol.sh`
1. `cat service-mesh.sh`
1. `./service-mesh.sh`
1. adjust the `docker-machine` security group to allows port 80 traffic to flow
1. run `watch 'curl --silent <IP address> | python3 -m json.tool'`, noticing the changing address and `HOSTNAME`
1. look up the **public** address of some of the other nodes and hit those
1. adjust the scale up or down and see how results are affected
1. `docker-machine ssh bravo docker service scale nginx=2`
1. `docker-machine ssh bravo docker service ps nginx`

# Lab 32: Function as a Service (FaaS)
>The business has decided that in order to stay competitive, our product needs to support developer extension points.  They want an experience similar to AWS Lambda where code written in a variety of programming languages can interact with our system in a safe and predictable manner.  Luckily, we've already covered everything we'll need to produce a Docker-based proof of concept.  In this lab, we'll create a FaaS implementation as a series of short shell scripts that interact with Docker that simulates the developer experience.  The implementation must support the following:
* JVM and Python based functions
* functions that accept a string and that return a string
* developer can specify the following runtime constraints
  * RAM
  * CPU
  * whether networking is needed or not
  * the name of the script to run
  * a file containing environment variables that the script can use for configuration

Create a script that launches a container using the appropriate image and runtime switches.  You will have two scripts, one for each runtime.  Your task is complete if the string passed to the script is printed in uppercase.  There is a solution in `solutions/lab-32` if you get stuck.

1. `git reset --hard`
1. `cd labs/lab-32`
1. `./clean-slate-protocol.sh`
1. `cat faas.env`
1. `cat faas.groovy`
1. `cat faas.py`
1. `cat run-groovy-function.sh`
1. `cat run-python-function.sh`
1. poke around [Docker Hub](https://hub.docker.com/explore/) to find the appropriate images

# Lab 33: AWS Docker Registry
>In this lab, we will host our images on Amazon instead of using public repositories.  Normally, this is done for security and operational reasons.  We will create the registry in our AWS account, push an image to it and have one of our classmates pull from it.  The container simply prints the current date and time.

1. `git reset --hard`
1. `git pull`
1. `cd labs/lab-33`
1. `./clean-slate-protocol.sh`
1. edit `Dockerfile` so that it creates an image that runs the Linux `date` command
1. edit `create-docker-image.sh` as needed to create the proper image
1. `./create-docker-image.sh` to create the image
1. run the proper Docker command to verify the image built correctly
1. edit `test-image.sh` so that it tests your image
1. `./test-image.sh` to verify your image works correctly
1. log into your AWS account, navigating to *Compute->Elastic Container Service*
1. create your repository.  You can call it anything you want but `aws-study-group` will be used in the solution
1. follow the instructions from Amazon on how to authenticate to your registry
1. edit `tag-image.sh` so that it tags the existing image with a tag suitable for your new repository
1. `./tag-image.sh` to tag the image
1. run the proper Docker command to verify the image got tagged correctly
1. edit `push.image.sh`
1. `./push-image.sh` to push it to the registry
1. use the console to verify the image made it
1. select a classmate
1. using the AWS console, give their account the ability to pull down your image
1. have them pull down your image and run it
1. Using the AWS console, figure out how to auto-delete images that are older than 30 days




# Lab N: [Docker Store](https://store.docker.com/)
# Lab N: Consul, Service Discovery and Docker
# Lab N: Personal Image Registry (4.8)
# Lab N: Dockerfile Madness (advanced) (4.5.10.10)
# Lab N: Docker Log Drivers (3.9)
# Lab N: Guts
1. /var/lib/docker/containers (3.15)
1. /var/lib/docker (4.2)
1.

# Tips and Tricks

# Troubleshooting

# License and Credits
This project is licensed under the [Apache License Version 2.0, January 2004](http://www.apache.org/licenses/).
