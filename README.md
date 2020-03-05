# HISTOGRAPHER INFRASTRUCTURE #

# Installation
- Create a copy of `.env.sample` with the name `.env`
- Fill the `.env` file where appropriate

## Local Development
- run `./generate_secrets.sh --dev` to fill .env with secrets for local development
- run `docker-compose up -d` to deploy

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
## Production 
- run `./generate_secrets.sh` to create docker secrets
- run `docker-compose config | docker stack deploy -c - prod` to deploy

# Update services
To push a new version of a service with its own dockerfile in this repo, use:
`docker-compose build <service> && docker-compose push <service>`
