FROM cytomine/nginx:v1.2.0

ADD nginx.conf.sample /tmp/nginx.conf.sample

RUN apt-get update && apt-get install -y curl

ADD run.sh /tmp/run.sh
ENTRYPOINT ["/tmp/run.sh"]
