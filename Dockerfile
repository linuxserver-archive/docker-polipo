FROM lsiobase/alpine
MAINTAINER sparklyballs

# install build packages
RUN \
 apk add --no-cache --virtual=build-dependencies \
	g++ \
	gcc \
	git \
	make \
	texinfo && \

# clone polipo source
 git clone https://github.com/jech/polipo /tmp/polipo-source && \

# configure and compile polipo
 cd /tmp/polipo-source && \
	make install && \

# uninstall build packages
 apk del --purge \
	build-dependencies && \

# cleanup
 rm -rfv \
	/tmp/*

# install runtime packages
RUN \
 apk add --no-cache \
	inotify-tools

# add local files
COPY root/ /

# ports and volumes
VOLUME /config
EXPOSE 8123
