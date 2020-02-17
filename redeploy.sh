#!/bin/sh

# Use this to redeploy services through a CI/CD setup
# usage: ./redeploy.sh <name-of-docker-service>
docker-compose build --pull --no-cache $1
docker-compose up -d $1
