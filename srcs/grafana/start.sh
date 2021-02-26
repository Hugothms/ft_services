#!/bin/sh

telegraf &
cd ./grafana/bin/ && ./grafana-server