FROM cytomine/nginx:v1.2.0

ADD nginx.conf.sample /tmp/nginx.conf.sample

ADD run.sh /tmp/run.sh
ENTRYPOINT ["/tmp/run.sh"]
