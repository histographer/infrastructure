# HISTOGRAPHER INFRASTRUCTURE #

## How to install and run

- Create a copy of .env.sample with the name .env
- Fill the .env file where appropriate
- - OPTIONAL: run ./generate_secrets.sh to fill empty secrets
- Run docker-compose up -d (-d is optional)


## Folder structure
Each folder in this repo represents a service, with all its config plus a dockerfile inside.

## Local development
For local development use:



And don't forget to add the following to your `/etc/hosts` file:
```
127.0.0.1   localhost-core
127.0.0.1   localhost-ims
127.0.0.1   localhost-ims2
127.0.0.1   localhost-upload
127.0.0.1   localhost-pat-or-nat-frontend
127.0.0.1   localhost-pat-or-nat-backend
127.0.0.1   localhost-analysis-rest-api
```

## Misc

View the logs of a specific service by running docker-compose logs -f <service>

## Known errors:

if you get:
`ERROR: for <service>  UnixHTTPConnectionPool(host='localhost', port=None): Read timed out. (read timeout=60)`
When running docker-compose, try using `COMPOSE_HTTP_TIMEOUT=120 docker-compose up`


## Production

`docker-compose -f docker-compose.prod.yml config | docker stack deploy -c - production`
