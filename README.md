![http://linuxserver.io](http://www.linuxserver.io/wp-content/uploads/2015/06/linuxserver_medium.png)

The [LinuxServer.io](https://www.linuxserver.io/) team brings you another quality container release featuring easy user mapping and community support. Be sure to checkout our [forums](https://forum.linuxserver.io/index.php) or for real-time support our [IRC](https://www.linuxserver.io/index.php/irc/) on freenode at `#linuxserver.io`.

# linuxserver/polipo

Polipo is a lightweight caching and forwarding web proxy server. It has a wide variety of uses, from aiding security by filtering traffic; to caching web, DNS and other computer network lookups for a group of people sharing network resources; to speeding up a web server by caching repeated requests.

## Usage

```
docker create --name=polipo -v /etc/localtime:/etc/localtime:ro -v <path to data>:/config -e PGID=<gid> -e PUID=<uid>  -p 8123:8123 linuxserver/polipo
```

**Parameters**

* `-p 8123` - the port(s)
* `-v /etc/localtime` for timesync - *optional*
* `-v /config` - location of configuration files
* `-e PGID` for GroupID - see below for explanation
* `-e PUID` for UserID - see below for explanation

It is based on alpine linux with s6 overlay, for shell access whilst the container is running do `docker exec -it polipo /bin/bash`.

### User / Group Identifiers

**TL;DR** - The `PGID` and `PUID` values set the user / group you'd like your container to 'run as' to the host OS. This can be a user you've created or even root (not recommended).

Part of what makes our containers work so well is by allowing you to specify your own `PUID` and `PGID`. This avoids nasty permissions errors with relation to data volumes (`-v` flags). When an application is installed on the host OS it is normally added to the common group called users, Docker apps due to the nature of the technology can't be added to this group. So we added this feature to let you easily choose when running your containers.

## Setting up the application 

Basic settings are pre-set by this container.  You can use the out of box experience or customize to your own preferences.


## Info

* To monitor the logs of the container in realtime `docker logs -f polipo`.



## Versions

+ **03.07.16:** Rebase to alpine for smaller image size.
+ **06.11.15:** Initial Release
