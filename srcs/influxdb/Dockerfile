FROM alpine:latest

RUN apk update
RUN apk add influxdb

RUN wget https://dl.influxdata.com/telegraf/releases/telegraf-1.16.3_linux_amd64.tar.gz
RUN mkdir -p /etc/telegraf
COPY ./telegraf.conf /etc/telegraf/telegraf.conf

COPY ./grafana.db /grafana/data/grafana.db

COPY ./start.sh ./start.sh
RUN chmod +x ./start.sh

EXPOSE 8086

#ENTRYPOINT ["/start.sh"]


CMD ["/bin/sh", "./start.sh"]
