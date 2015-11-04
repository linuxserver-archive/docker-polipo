FROM linuxserver/baseimage
MAINTAINER smdion <me@seandion.com>
ENV APTLIST="polipo inotify-tools"

# Install Polipo
RUN \
  apt-get update -q && \
  apt-get install $APTLIST -qy && \

# clean up 
apt-get clean && rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

# adding custom files
ADD services/ /etc/service/
ADD init/ /etc/my_init.d/
RUN chmod -v +x /etc/service/*/run /etc/service/*/finish && chmod -v +x /etc/my_init.d/*.sh && \

# configure polipo
cp /usr/share/doc/polipo/examples/config.sample /defaults/polipo.conf && \

#Allow outside access
sed -i -e 's/# proxyAddress = "0.0.0.0"/proxyAddress = "0.0.0.0"/' /defaults/polipo.conf && \

#set cache folder
sed -i '61,64d' /defaults/polipo.conf && \
sed -i -e 's/# diskCacheRoot/diskCacheRoot/g' /defaults/polipo.conf && \
sed -i 's|'"~/.polipo-cache/"'|'"/config/cache/"'|' /defaults/polipo.conf && \

#high memory
sed -i -e 's/# chunkHighMark = 50331648/chunkHighMark = 50331648/' /defaults/polipo.conf && \
sed -i -e 's/# objectHighMark = 16384/objectHighMark = 16384/' /defaults/polipo.conf && \

#disable indexing/servers list
sed -i -e 's/# disableIndexing = false/disableIndexing = false/' /defaults/polipo.conf && \
sed -i -e 's/# disableServersList = false/disableServersList = false/' /defaults/polipo.conf && \

#increase security
sed -i -e 's/# censoredHeaders = from, accept-language/censoredHeaders = from, accept-language/' /defaults/polipo.conf && \
sed -i -e 's/# censorReferer = maybe/censorReferer = maybe/' /defaults/polipo.conf && \

#set expire time
echo "" >>/defaults/polipo.conf && \
echo "# Server Expire Time" >>/defaults/polipo.conf && \
echo "serverExpireTime = 5d" >>/defaults/polipo.conf && \

#only allow internal clients
sed -i '23d' /defaults/polipo.conf && \
sed -i -e 's|# allowedClients = 127.0.0.1, 192.168.42.0/24|allowedClients = 127.0.0.1, 10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16|' /defaults/polipo.conf && \

#set proxy name
sed -i -e 's/# proxyName = "polipo.example.org"/proxyName = "unRAID.Polipo"/' /defaults/polipo.conf

# volumes and ports
VOLUME /config
EXPOSE 8123
