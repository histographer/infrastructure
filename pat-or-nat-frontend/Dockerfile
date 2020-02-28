FROM docker.pkg.github.com/histographer/pat-or-nat-frontend/pat-or-nat-frontend:latest

ADD nginx.conf.sample /tmp/nginx.conf.sample


ADD run.sh /tmp/run.sh
ENTRYPOINT ["/tmp/run.sh"]
