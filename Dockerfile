FROM lsiobase/alpine:3.8 as buildstage
############## build stage ##############

RUN \
 echo "**** install build packages ****" && \
 apk add --no-cache \
	g++ \
	gcc \
	git \
	inotify-tools \
	make \
	texinfo

RUN \
 echo "**** compile polipo ****" && \
 git clone https://github.com/jech/polipo \
	/tmp/polipo-source && \
 cd /tmp/polipo-source && \
 make install

############## runtime stage ##############
FROM lsiobase/alpine:3.8

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="sparklyballs"

RUN \
 echo "**** install runtime packages ****" && \
 apk add --no-cache \
	inotify-tools

# copy buildstage and local files
COPY --from=buildstage /tmp/polipo-source/polipo /usr/local/bin/polipo
COPY --from=buildstage /tmp/polipo-source/html/ /usr/share/polipo/www/doc/
COPY --from=buildstage /tmp/polipo-source/localindex.html /usr/share/polipo/www/index.html
COPY --from=buildstage /tmp/polipo-source/polipo.man /usr/local/man/man1/polipo.1
COPY --from=buildstage /tmp/polipo-source/polipo.info /usr/local/info/
COPY root/ /

# ports and volumes
EXPOSE 8123
VOLUME /config
