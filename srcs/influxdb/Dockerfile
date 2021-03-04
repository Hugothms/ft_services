FROM alpine:latest

RUN apk update
RUN apk add influxdb

RUN apk add --no-cache telegraf --repository=http://nl.alpinelinux.org/alpine/edge/testing
RUN mkdir -p /etc/telegraf
COPY telegraf.conf		/etc/telegraf/

# COPY grafana.db /grafana/data/grafana.db

COPY start.sh	start.sh
RUN chmod +x	start.sh

EXPOSE 8086

CMD /bin/sh start.sh
