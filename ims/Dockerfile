FROM cytomine/ims:v1.2.2

ADD addHosts.sh.sample /tmp/addHosts.sh.sample
ADD imageserverconfig.properties.sample /tmp/imageserverconfig.properties.sample

ADD run.sh /tmp/run.sh
ENTRYPOINT ["/tmp/run.sh"]
