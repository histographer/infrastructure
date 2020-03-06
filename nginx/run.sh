#!/bin/bash
function configure() {
  srcPath=$1
  dstPath=$2
  echo "File ${srcPath} to ${dstPath}"
  cp "$srcPath" "$dstPath"
  while read LINE; do
    if [[ $LINE == *"="* ]]; then
      name=$(echo $LINE | cut -f1 -d "=")
      value=$(echo $LINE | cut -f2 -d "=")
      sed -i "s~\\\$${name}~${value}~g" $dstPath
    fi
  done <<<"$(env)"
}
function secretsToEnv() {
  if [[ -d "/run/secrets" ]]; then
    echo "Reading secrets"
    while read FILE; do
      export "$FILE=$(cat /run/secrets/$FILE)"
    done <<<"$(ls /run/secrets)"
  fi
}; secretsToEnv

configure /tmp/nginx.conf.sample /usr/local/nginx/conf/nginx.conf

mkdir -p /tmp/uploaded && chmod 777 /tmp/uploaded

echo "/usr/local/nginx/logs/access.log {"   > /etc/logrotate.d/nginx
echo "  copytruncate"                      >> /etc/logrotate.d/nginx
echo "  daily"                             >> /etc/logrotate.d/nginx
echo "  size 250M"                         >> /etc/logrotate.d/nginx
echo "  rotate 14"                         >> /etc/logrotate.d/nginx
echo "  compress"                          >> /etc/logrotate.d/nginx
echo "  missingok"                         >> /etc/logrotate.d/nginx
echo "  create 640 root root"              >> /etc/logrotate.d/nginx
echo "}"                                   >> /etc/logrotate.d/nginx
echo ""                                    >> /etc/logrotate.d/nginx
echo "/usr/local/nginx/logs/error.log {"   >> /etc/logrotate.d/nginx
echo "  copytruncate"                      >> /etc/logrotate.d/nginx
echo "  daily"                             >> /etc/logrotate.d/nginx
echo "  size 250M"                         >> /etc/logrotate.d/nginx
echo "  rotate 14"                         >> /etc/logrotate.d/nginx
echo "  compress"                          >> /etc/logrotate.d/nginx
echo "  missingok"                         >> /etc/logrotate.d/nginx
echo "  create 640 root root"              >> /etc/logrotate.d/nginx
echo "}"                                   >> /etc/logrotate.d/nginx


echo "Launch of nginx"
/usr/local/nginx/sbin/nginx || { echo 'Nginx crashed!' ; exit 1; }

tail -F /usr/local/nginx/logs/access.log
