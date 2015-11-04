FROM linuxserver/baseimage
MAINTAINER smdion <me@seandion.com>
ENV APTLIST="polipo inotify-tools"

# Install Polipo
RUN \
  echo "deb http://us.archive.ubuntu.com/ubuntu/ trusty universe multiverse" >> /etc/apt/sources.list && \
  echo "deb http://us.archive.ubuntu.com/ubuntu/ trusty-updates universe multiverse" >> /etc/apt/sources.list && \
  apt-get update -q && \
  apt-get install $APTLIST -qy && \

# clean up 
apt-get clean && rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

# volumes and ports
VOLUME /config
EXPOSE 8123

# adding custom files
ADD services/ /etc/service/
ADD init/ /etc/my_init.d/
RUN chmod -v +x /etc/service/*/run /etc/service/*/finish && chmod -v +x /etc/my_init.d/*.sh
