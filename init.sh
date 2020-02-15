# Delete env file if exist
[ -e ".env" ] && rm ".env"

#Generate config and env files
ENV=(
  CORE_URL='core.digipat.no'
  IMS_URL1='ims.digipat.no'
  IMS_URL2='ims2.digipat.no'
  UPLOAD_URL='upload.digipat.no'

  ADMIN_EMAIL='info@cytomine.coop'
  SENDER_EMAIL_PASS='passwd'
  SENDER_EMAIL_SMTP_HOST='smtp.gmail.com'
  SENDER_EMAIL_SMTP_PORT='587'
  SENDER_EMAIL='your.email@gmail.com'
  RECEIVER_EMAIL='receiver@XXX.com'

  IMS_STORAGE_PATH=/data/images
  IMS_BUFFER_PATH=/data/images/_buffer
  BACKUP_PATH=/data/backup
  ALGO_PATH=/data/algo/

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

#Generate config files
FILES=(configs/core/cytomineconfig.groovy configs/ims/imageserverconfig.properties configs/iipCyto/nginx.conf.sample configs/iipOff/nginx.conf.sample configs/nginx/nginx.conf configs/nginx/nginxDev.conf configs/nginx/dist/configuration.json configs/software_router/config.groovy start_deploy.sh hosts/core/addHosts.sh hosts/ims/addHosts.sh hosts/software_router/addHosts.sh)
for i in ${FILES[@]}; do
  if [ -f "$i.sample" ]; then
    cp $i.sample $i

    for j in ${ENV[@]}; do
      eval sed -i "s~\\\$$j~\$$j~g" $i
    done
  fi
done
