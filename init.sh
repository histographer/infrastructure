#!/bin/bash

# FILL IN BELOW (LEAVE BLANK FOR DEFAULT)
ENV=(
  CORE_URL='localhost-core'
  IMS_URL1='localhost-ims'
  IMS_URL2='localhost-ims2'
  UPLOAD_URL='localhost-upload'
  PAT_OR_NAT_FRONTEND_URL='localhost-pat-or-nat-frontend'
  ADMIN_EMAIL='info@cytomine.coop'
  SENDER_EMAIL_PASS='passwd'
  SENDER_EMAIL_SMTP_HOST='smtp.gmail.com'
  SENDER_EMAIL_SMTP_PORT='587'
  SENDER_EMAIL='your.email@gmail.com'
  RECEIVER_EMAIL='receiver@XXX.com'
  IMS_STORAGE_PATH=/data/images
  IMS_BUFFER_PATH=/data/images/_buffer
  BACKUP_PATH=/data/backup
  ALGO_PATH=/data/algo
  RABBITMQ_LOGIN="router"
  RABBITMQ_PASS="router"

  # You don't have to change the datas below this line instead of advanced customization
  # ---------------------------
  NB_IIP_PROCESS=10
  IIP_OFF_URL=localhost-iip-base
  IIP_CYTO_URL=localhost-iip-cyto
  IIP_JP2_URL=localhost-iip-jp2000
  MEMCACHED_PASS="mypass"
  BIOFORMAT_ENABLED=true
  BIOFORMAT_ALIAS="bioformat"
  BIOFORMAT_PORT="4321"
  # ---------------------------

)









# DONT EDIT BENEATH THIS LINE

# Detect .env file
if [[ -e ".env" ]]; then
 clear
 echo "ATTENTION!"
 echo " "
 echo "A .env file is detected in your current directory."
 echo "This likely means the init.sh script already have been run."
 echo "Running again will generate new data such as admin password etc. and overwrite the old."
 echo "Before doing this, ensure that you have cleaned up any previous instance of the bootstrapper."
 read -r -p "Do you want to re-run the script? [y/N] " response
 case "$response" in
    [yY][eE][sS]|[yY])
        rm .env
        clear
        ;;
    *)
        exit 0;
        ;;
 esac
fi


echo "Configuring..."
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
  )
fi

#Append variables to .env file
for var in ${ENV[@]}; do
  echo $var >>".env"
done
source .env

# Find all files that end in .sample
FILES=()
while IFS= read -d $'\0' -r file; do
  FILES=("${FILES[@]}" "$file")

done < <(find . -name "*.sample" -not -path "./.git/*" -print0)

#Replace contents of .sample files with env variables and create config files
for i in ${FILES[@]}; do
  cp "$i" "${i%%.sample}"

  for j in ${ENV[@]}; do
    name=$(echo $j | cut -f1 -d "=")
    value=$(echo $j | cut -f2 -d "=")
    if [[ "$OSTYPE" == "darwin"* ]]; then #check if OSX
      sed -i '' "s~\\\$${name}~${value}~g" ${i%%.sample}
    else
      sed -i "s~\\\$${name}~${value}~g" ${i%%.sample}
    fi
  done
done


# Build docker images
docker-compose build


clear
echo "Cool, the server is now ready. Start it with:"
echo -e "\033[1mdocker-compose up -d\033[22m"
echo " "
echo -e "After a little while (depending on your hardware), the client should be available at \033[4;94mhttp://$(echo $CORE_URL)\033[0m"
echo -e "Administrator login details are\033[1m admin\033[0m:\033[1m$(echo $ADMIN_PWD)\033[0m"
echo " "
echo "NOTE: The init.sh script should only be run once. "
