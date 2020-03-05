#!/bin/bash

echo "Removing old.."
docker secret rm $(docker secret ls -q)
rm DELETE_ME_SECRETS.txt

echo "Creating secrets..."
if [[ $* == *--dev* ]]; then
  if [ ! -f /tmp/foo.txt ]; then
    echo "You have to create a .env file from .env.sample first. Ensure that this does not already contain any secrets."
  else
    printf "ADMIN_PWD=" >>.env && printf $(/usr/bin/uuidgen) >>.env
    printf "\nADMIN_PUB_KEY=" >>.env && printf $(/usr/bin/uuidgen) >>.env
    printf "\nADMIN_PRIV_KEY=" >>.env && printf $(/usr/bin/uuidgen) >>.env
    printf "\nSUPERADMIN_PUB_KEY=" >>.env && printf $(/usr/bin/uuidgen) >>.env
    printf "\nSUPERADMIN_PRIV_KEY=" >>.env && printf $(/usr/bin/uuidgen) >>.env
    printf "\nRABBITMQ_PUB_KEY=" >>.env && printf $(/usr/bin/uuidgen) >>.env
    printf "\nRABBITMQ_PRIV_KEY=" >>.env && printf $(/usr/bin/uuidgen) >>.env
    printf "\nIMS_PUB_KEY=" >>.env && printf $(/usr/bin/uuidgen) >>.env
    printf "\nIMS_PRIV_KEY=" >>.env && printf $(/usr/bin/uuidgen) >>.env
    printf "\nSERVER_ID=" >>.env && printf $(/usr/bin/uuidgen) >>.env
    printf "\nPATORNAT_MONGODB_PASSWORD=" >>.env && printf $(/usr/bin/uuidgen) >>.env
    printf "\nPATORNAT_MONGODB_ROOT_PASSWORD=" >>.env && printf $(/usr/bin/uuidgen) >>.env
    printf "\nPATORNAT_INITDB_MONGODB_ROOT_PASSWORD=" >>.env && printf $(/usr/bin/uuidgen) >>.env
  fi
else
  printf "ADMIN_PWD: " >>DELETE_ME_SECRETS.txt && printf $(/usr/bin/uuidgen) | tee -a DELETE_ME_SECRETS.txt | docker secret create ADMIN_PWD -
  printf "\nADMIN_PUB_KEY: " >>DELETE_ME_SECRETS.txt && printf $(/usr/bin/uuidgen) | tee -a DELETE_ME_SECRETS.txt | docker secret create ADMIN_PUB_KEY -
  printf "\nADMIN_PRIV_KEY: " >>DELETE_ME_SECRETS.txt && printf $(/usr/bin/uuidgen) | tee -a DELETE_ME_SECRETS.txt | docker secret create ADMIN_PRIV_KEY -
  printf "\nSUPERADMIN_PUB_KEY: " >>DELETE_ME_SECRETS.txt && printf $(/usr/bin/uuidgen) | tee -a DELETE_ME_SECRETS.txt | docker secret create SUPERADMIN_PUB_KEY -
  printf "\nSUPERADMIN_PRIV_KEY: " >>DELETE_ME_SECRETS.txt && printf $(/usr/bin/uuidgen) | tee -a DELETE_ME_SECRETS.txt | docker secret create SUPERADMIN_PRIV_KEY -
  printf "\nRABBITMQ_PUB_KEY: " >>DELETE_ME_SECRETS.txt && printf $(/usr/bin/uuidgen) | tee -a DELETE_ME_SECRETS.txt | docker secret create RABBITMQ_PUB_KEY -
  printf "\nRABBITMQ_PRIV_KEY: " >>DELETE_ME_SECRETS.txt && printf $(/usr/bin/uuidgen) | tee -a DELETE_ME_SECRETS.txt | docker secret create RABBITMQ_PRIV_KEY -
  printf "\nIMS_PUB_KEY: " >>DELETE_ME_SECRETS.txt && printf $(/usr/bin/uuidgen) | tee -a DELETE_ME_SECRETS.txt | docker secret create IMS_PUB_KEY -
  printf "\nIMS_PRIV_KEY: " >>DELETE_ME_SECRETS.txt && printf $(/usr/bin/uuidgen) | tee -a DELETE_ME_SECRETS.txt | docker secret create IMS_PRIV_KEY -
  printf "\nSERVER_ID: " >>DELETE_ME_SECRETS.txt && printf $(/usr/bin/uuidgen) | tee -a DELETE_ME_SECRETS.txt | docker secret create SERVER_ID -
  printf "\nPATORNAT_MONGODB_PASSWORD: " >>DELETE_ME_SECRETS.txt && printf $(/usr/bin/uuidgen) | tee -a DELETE_ME_SECRETS.txt | docker secret create PATORNAT_MONGODB_PASSWORD -
  printf "\nPATORNAT_MONGODB_ROOT_PASSWORD: " >>DELETE_ME_SECRETS.txt && printf $(/usr/bin/uuidgen) | tee -a DELETE_ME_SECRETS.txt | docker secret create PATORNAT_MONGODB_ROOT_PASSWORD -
  printf "\nPATORNAT_INITDB_MONGODB_ROOT_PASSWORD: " >>DELETE_ME_SECRETS.txt && printf $(/usr/bin/uuidgen) | tee -a DELETE_ME_SECRETS.txt | docker secret create PATORNAT_INITDB_MONGODB_ROOT_PASSWORD -
fi
