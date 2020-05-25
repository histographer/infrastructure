# HISTOGRAPHER INFRASTRUCTURE #
You need to have docker and docker-compose installed

# Installation
- Create a copy of `.env.sample` with the name `.env`
- Fill the `.env` file where appropriate

## Local Development 
- run `docker-compose -f docker-compose.traefik.yml up -d` to run the traefik container
- run `docker-compose -f docker-compose.cytomine.yml up -d` to run the cytomine service
- run `docker-compose -f docker-compose.analysis.yml up -d` to run the analysis service
  - [Analysis repository](https://github.com/histographer/histographer-analysis)
- run `docker-compose -f docker-compose.wizard.yml up -d` to run the wizard service
  - [Wizard backend repository](https://github.com/histographer/wizard-backend)
  - [Wizard frontend repository](https://github.com/histographer/wizard-frontend)
- run `docker-compose -f docker-compose.compare.yml up -d` to run the compare service
  - [Compare backend repository](https://github.com/histographer/compare-backend)
  - [Compare frontent repository](https://github.com/histographer/compare-frontend)

### Mac OS specifics
You need to create local folders that you specify under `#the storage path for your server` in .env. Make sure you have the correct path and have access to the folders. If you do not do this correctly, you will not be able to upload images.

## Production 
To create safe passwords, we recommend to run `./generate_secrets.sh` and copy the passwords that are generated over to `.env`.

You can follow the same proceedure as with local development if you only intend to run some of the services. 
If you want to run all services, run `./docker-containers-up.sh` and they will deploy.
