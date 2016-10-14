FROM lsiobase/alpine
MAINTAINER sparklyballs

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"

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
