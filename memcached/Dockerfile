FROM cytomine/memcached:v1.1.2

ADD memcached.conf.sample /tmp/memcached.conf.sample

ADD run.sh /tmp/run.sh
ENTRYPOINT ["/tmp/run.sh"]
