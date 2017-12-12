[linuxserverurl]: https://linuxserver.io
[forumurl]: https://forum.linuxserver.io
[ircurl]: https://www.linuxserver.io/irc/
[podcasturl]: https://www.linuxserver.io/podcast/
[appurl]: https://github.com/jech/polipo
[hub]: https://hub.docker.com/r/lsiocommunity/polipo/

[![linuxserver.io](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/linuxserver_medium.png)][linuxserverurl]

The [LinuxServer.io][linuxserverurl] team brings you another container release featuring easy user mapping and community support. Find us for support at:
* [forum.linuxserver.io][forumurl]
* [IRC][ircurl] on freenode at `#linuxserver.io`
* [Podcast][podcasturl] covers everything to do with getting the most from your Linux Server plus a focus on all things Docker and containerisation!

# lsiocommunity/polipo
[![](https://images.microbadger.com/badges/version/lsiocommunity/polipo.svg)](https://microbadger.com/images/lsiocommunity/polipo "Get your own version badge on microbadger.com")[![](https://images.microbadger.com/badges/image/lsiocommunity/polipo.svg)](http://microbadger.com/images/lsiocommunity/polipo "Get your own image badge on microbadger.com")[![Docker Pulls](https://img.shields.io/docker/pulls/lsiocommunity/polipo.svg)][hub][![Docker Stars](https://img.shields.io/docker/stars/lsiocommunity/polipo.svg)][hub][![Build Status](https://ci.linuxserver.io/buildStatus/icon?job=Docker-Builders/lsiocommunity/x86-64-polipo)](https://ci.linuxserver.io/job/Docker-Builders/job/lsiocommunity/job/x86-64-polipo/)

Polipo is a lightweight caching and forwarding web proxy server. It has a wide variety of uses, from aiding security by filtering traffic; to caching web, DNS and other computer network lookups for a group of people sharing network resources; to speeding up a web server by caching repeated requests.

[![polipo](http://www.leostickers.com/prod_imgs//Prod_2403.png)][appurl]

## Usage

```
docker create \
--name=polipo \
-v <path to data>:/config \
-e PGID=<gid> -e PUID=<uid> \
-e TZ=<timezone> \
-p 8123:8123 \
lsiocommunity/polipo
```

## Parameters

`The parameters are split into two halves, separated by a colon, the left hand side representing the host and the right the container side. 
For example with a port -p external:internal - what this shows is the port mapping from internal to external of the container.
So -p 8080:80 would expose port 80 from inside the container to be accessible from the host's IP on port 8080
http://192.168.x.x:8080 would show you what's running INSIDE the container on port 80.`


* `-p 8123` - the port(s)
* `-v /config` - location of configuration files
* `-e PGID` for GroupID - see below for explanation
* `-e PUID` for UserID - see below for explanation
* `-e TZ` for setting timezone information, eg Europe/London

It is based on alpine linux with s6 overlay, for shell access whilst the container is running do `docker exec -it polipo /bin/bash`.

### User / Group Identifiers

Sometimes when using data volumes (`-v` flags) permissions issues can arise between the host OS and the container. We avoid this issue by allowing you to specify the user `PUID` and group `PGID`. Ensure the data volume directory on the host is owned by the same user you specify and it will "just work" ™.

In this instance `PUID=1001` and `PGID=1001`. To find yours use `id user` as below:

```
  $ id <dockeruser>
    uid=1001(dockeruser) gid=1001(dockergroup) groups=1001(dockergroup)
```

## Setting up the application 

Basic settings are pre-set by this container.  You can use the out of box experience or customize to your own preferences.


## Info

* To monitor the logs of the container in realtime `docker logs -f polipo`.

* container version number 

`docker inspect -f '{{ index .Config.Labels "build_version" }}' polipo`

* image version number

`docker inspect -f '{{ index .Config.Labels "build_version" }}' lsiocommunity/polipo`

## Versions

+ **12.12.17:** Rebase to alpine 3.7.
+ **28.05.17:** Rebase to alpine 3.6.
+ **08.02.17:** Rebase to alpine 3.5.
+ **14.10.16:** Add version layer information.
+ **30.09.16:** Fix umask
+ **11.09.16:** Move to lsiocommunity
+ **03.07.16:** Rebase to alpine for smaller image size.
+ **06.11.15:** Initial Release
