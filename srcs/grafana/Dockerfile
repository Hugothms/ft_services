FROM alpine:latest

RUN apk update && apk add --no-cache --upgrade bash
RUN apk add openrc

RUN wget https://dl.influxdata.com/telegraf/releases/telegraf-1.16.3_linux_amd64.tar.gz
RUN mkdir -p /etc/telegraf
COPY ./telegraf.conf /etc/telegraf/telegraf.conf

RUN wget --output-file=grafana.tar.gz https://dl.grafana.com/oss/release/grafana-7.3.4.linux-amd64.tar.gz
RUN tar -zxvf grafana-7.3.4.linux-amd64.tar.gz
RUN mv grafana-7.3.4 grafana
RUN rm grafana.tar.gz

RUN apk add --no-cache --repository=http://dl-cdn.alpinelinux.org/alpine/edge/main libc6-compat

COPY ./grafana.db ./grafana/data/

COPY start.sh ./start.sh
RUN chmod +x ./start.sh

EXPOSE 3000

CMD ["/bin/sh", "./start.sh"]
