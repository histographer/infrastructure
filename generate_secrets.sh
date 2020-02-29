#!/bin/bash

ENV=()

echo "Generating secrets..."
echo "!!!!NEVER store secrets in plaintext like this in a production environment, this is only for development purposes!!!!"
# Secret keys
if [[ "$OSTYPE" == "darwin"* ]]; then #check if OSX
  ENV+=(
    ADMIN_PWD=$(/usr/bin/uuidgen)
    ADMIN_PUB_KEY=$(/usr/bin/uuidgen)
    ADMIN_PRIV_KEY=$(/usr/bin/uuidgen)
    SUPERADMIN_PUB_KEY=$(/usr/bin/uuidgen)
    SUPERADMIN_PRIV_KEY=$(/usr/bin/uuidgen)
    RABBITMQ_PUB_KEY=$(/usr/bin/uuidgen)
    RABBITMQ_PRIV_KEY=$(/usr/bin/uuidgen)
    IMS_PUB_KEY=$(/usr/bin/uuidgen)
    IMS_PRIV_KEY=$(/usr/bin/uuidgen)
    SERVER_ID=$(/usr/bin/uuidgen)
    PATORNAT_MONGODB_PASSWORD=$(/usr/bin/uuidgen)
    PATORNAT_MONGODB_ROOT_PASSWORD=$(/usr/bin/uuidgen)
  )
else
  ENV+=(
    ADMIN_PWD=$(cat /proc/sys/kernel/random/uuid)
    ADMIN_PUB_KEY=$(cat /proc/sys/kernel/random/uuid)
    ADMIN_PRIV_KEY=$(cat /proc/sys/kernel/random/uuid)
    SUPERADMIN_PUB_KEY=$(cat /proc/sys/kernel/random/uuid)
    SUPERADMIN_PRIV_KEY=$(cat /proc/sys/kernel/random/uuid)
    RABBITMQ_PUB_KEY=$(cat /proc/sys/kernel/random/uuid)
    RABBITMQ_PRIV_KEY=$(cat /proc/sys/kernel/random/uuid)
    IMS_PUB_KEY=$(cat /proc/sys/kernel/random/uuid)
    IMS_PRIV_KEY=$(cat /proc/sys/kernel/random/uuid)
    SERVER_ID=$(cat /proc/sys/kernel/random/uuid)
    PATORNAT_MONGODB_PASSWORD=$(cat /proc/sys/kernel/random/uuid)
    PATORNAT_MONGODB_ROOT_PASSWORD=$(cat /proc/sys/kernel/random/uuid)
  )
fi

dst=".env"
for j in ${ENV[@]}; do
  name=$(echo $j | cut -f1 -d "=")
  value=$(echo $j | cut -f2 -d "=")
  if [[ "$OSTYPE" == "darwin"* ]]; then #check if OSX
    sed -i '' "s/^${name}=$/${name}=${value}/g" $dst
  else
    sed -i "s/^${name}=$/${name}=${value}/g" $dst
  fi
done
