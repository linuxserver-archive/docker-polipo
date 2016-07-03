FROM lsiobase/xenial
MAINTAINER smdion , sparklyballs

# set environment variables
ARG DEBIAN_FRONTEND="noninteractive"

# install packages
RUN \
 apt-get update && \
 apt-get install -y \
	polipo && \

# clean up
 apt-get clean && \
 rm -rfv \
	/tmp/* \
	/var/lib/apt/lists/* \
	/var/tmp/*

# add local files
COPY root/ /

# ports and volumes
VOLUME /config
EXPOSE 8123
