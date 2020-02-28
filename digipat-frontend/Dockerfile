FROM docker.pkg.github.com/histographer/digipat-frontend/digipat-frontend:latest

ADD nginx.conf.sample /tmp/nginx.conf.sample
ADD configuration.json.sample /tmp/configuration.json.sample

ADD run.sh /tmp/run.sh
ENTRYPOINT ["/tmp/run.sh"]
