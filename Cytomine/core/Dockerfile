FROM cytomine/core:v2.0.0

ADD addHosts.sh.sample /tmp/addHosts.sh.sample
ADD cytomineconfig.groovy.sample /tmp/cytomineconfig.groovy.sample

ADD run.sh /tmp/run.sh
ENTRYPOINT ["/tmp/run.sh"]
