# HISTOGRAPHER INFRASTRUCTURE #
You need to have docker and docker-compose installed

# Installation
- Create a copy of `.env.sample` with the name `.env`
- Fill the `.env` file where appropriate

## Local Development 
- run `docker-compose -f docker-compose.traefik.yml up -d` to run the traefik container
- run `docker-compose -f docker-compose.cytomine.yml up -d` to run the cytomine service

### Mac OS specifics
You need to create local folders that you specify under `#the storage path for your server` in .env. Make sure you have the correct path and have access to the folders. If you do not do this correctly, you will not be able to upload images.


/// UNDER HERE IS OLD/UNDER PROGRESS PLEASE IGNORE UNTIL THIS IS REMOVED
## Local Development
- run `./generate_secrets.sh --dev` to fill .env with secrets for local development
- run `docker-compose up -d` to deploy

And don't forget to add the following to your `/etc/hosts` file:
```
127.0.0.1   localhost-core
127.0.0.1   localhost-ims
127.0.0.1   localhost-ims2
127.0.0.1   localhost-upload
127.0.0.1   localhost-compare-frontend
127.0.0.1   localhost-compare-backend
127.0.0.1   localhost-analysis-rest-api
```

## Production 
- run `./generate_secrets.sh` to create docker secrets
- run `docker-compose config | docker stack deploy -c - prod` to deploy

# Update services
To push a new version of a service with its own dockerfile in this repo, use:
`docker-compose build <service> && docker-compose push <service>`
