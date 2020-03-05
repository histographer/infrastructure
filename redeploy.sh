#!/bin/sh

# Use this to redeploy services through a CI/CD setup
# usage: ./redeploy.sh <name-of-docker-service>
docker service update $1
