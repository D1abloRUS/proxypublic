FROM alpine:latest

ENV JOBS=1000 \
    DIR=/opt/nginx \
    SITE=https://m.vk.com

RUN apk --no-cache add --update \
      geoip \
      curl \
      parallel \
    && wget http://geolite.maxmind.com/download/geoip/database/GeoLiteCountry/GeoIP.dat.gz \
    && gunzip GeoIP.dat.gz \
    && mv GeoIP.dat /usr/share/GeoIP/ \
    && rm -rf /root/..?* /root/.[!.]* /root/* /tmp/* GeoIP.dat.gz

COPY proxy_check.sh docker-entrypoint.sh /usr/local/bin/

VOLUME /opt

WORKDIR /opt

ENTRYPOINT ["docker-entrypoint.sh"]
