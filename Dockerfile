# USAGE:
#	docker run -d --name transmission \
#		-v /home/$user/Torrents:/transmission/download \
#		-p 9091:9091 -p 51413:51413 -p 51413:51413/udp \
#		jeyglk/transmission
#

# Base docker image
FROM alpine:latest
MAINTAINER "Jeremy Mathevet <jeremy@mathevet.net>"

RUN apk --no-cache add \
	transmission-daemon \
	&& mkdir -p /transmission/download \
		/transmission/watch \
		/transmission/incomplete \
		/transmission/config \
	&& chmod 1777 /transmission

COPY ./transmission.settings.json /transmission/config/settings.json

ENV TRANSMISSION_HOME /transmission/config

EXPOSE 9091

ENTRYPOINT ["/usr/bin/transmission-daemon"]
CMD [ "--allowed", "127.*,10.*,192.168.*,172.16.*,172.17.*,172.18.*,172.19.*,172.20.*,172.21.*,172.22.*,172.23.*,172.24.*,172.25.*,172.26.*,172.27.*,172.28.*,172.29.*,172.30.*,172.31.*,169.254.*", "--watch-dir", "/transmission/watch", "--encryption-preferred", "--foreground", "--config-dir", "/transmission/config", "--incomplete-dir", "/transmission/incomplete", "--dht", "--no-auth", "--download-dir", "/transmission/download" ]
