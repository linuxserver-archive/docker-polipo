FROM lsiobase/alpine:3.7

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="sparklyballs"

RUN \
 echo "**** install build packages ****" && \
 apk add --no-cache --virtual=build-dependencies \
	g++ \
	gcc \
	git \
	make \
	texinfo && \
 echo "**** install runtime packages ****" && \
 apk add --no-cache \
	inotify-tools && \
 echo "**** build polipo ****" && \
 git clone https://github.com/jech/polipo \
	/tmp/polipo-source && \
 cd /tmp/polipo-source && \
 make install && \
 echo "**** cleanup ****" && \
 apk del --purge \
	build-dependencies && \
 rm -rf \
	/tmp/*

# add local files
COPY root/ /

# ports and volumes
EXPOSE 8123
VOLUME /config
