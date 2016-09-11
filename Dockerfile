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

# install runtime packages
 apk add --no-cache \
	inotify-tools && \

# clone polipo source
 git clone https://github.com/jech/polipo \
	/tmp/polipo-source && \

# configure and compile polipo
 cd /tmp/polipo-source && \
 make \
	install && \

# uninstall build packages
 apk del --purge \
	build-dependencies && \

# cleanup
 rm -rfv \
	/tmp/*

# add local files
COPY root/ /

# ports and volumes
EXPOSE 8123
VOLUME /config
