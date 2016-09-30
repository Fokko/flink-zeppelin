#!/usr/bin/env sh

docker-compose kill && docker-compose rm -f && docker-compose up
docker-compose scale taskmanager=4
