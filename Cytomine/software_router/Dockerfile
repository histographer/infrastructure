FROM cytomine/software_router:v1.1.1

ADD addHosts.sh.sample /tmp/addHosts.sh.sample
ADD config.groovy.sample /tmp/config.groovy.sample

ADD run.sh /tmp/run.sh
ENTRYPOINT ["/tmp/run.sh"]
