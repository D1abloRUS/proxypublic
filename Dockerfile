FROM alpine:latest

ENV JOBS=100 \
    DIR=/opt/nginx \
    SITE=https://m.vk.com

ADD https://github.com/D1abloRUS/go-proxycheck/releases/download/v0.1/go-proxycheck /usr/local/bin/go-proxycheck
ADD http://geolite.maxmind.com/download/geoip/database/GeoLite2-Country.mmdb.gz /usr/share/GeoIP/
COPY docker-entrypoint.sh /usr/local/bin/

RUN apk --no-cache add --update \
      ca-certificates \
    && chmod +x /usr/local/bin/go-proxycheck \
    && gunzip /usr/share/GeoIP/GeoLite2-Country.mmdb.gz \
    && rm -rf /root/..?* /root/.[!.]* /root/* /tmp/*

VOLUME /opt

WORKDIR /opt

ENTRYPOINT ["docker-entrypoint.sh"]
