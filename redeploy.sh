#!/bin/sh

# Use this to redeploy services through a CI/CD setup
# usage: ./redeploy.sh <image> <name-of-docker-service>
docker service update --image $1 $2
