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

configure /tmp/imageserverconfig.properties.sample /usr/share/tomcat7/.grails/imageserverconfig.properties
configure /tmp/addHosts.sh.sample /tmp/addHosts.sh

/tmp/deploy.sh