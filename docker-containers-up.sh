docker network create traefik
docker-compose -f docker-compose.traefik.yml pull
docker-compose -f docker-compose.analysis.yml pull
docker-compose -f docker-compose.cytomine.yml pull
docker-compose -f docker-compose.wizard.yml pull
docker-compose -f docker-compose.compare.yml pull
docker-compose -f docker-compose.traefik.yml up -d
docker-compose -f docker-compose.analysis.yml up -d
docker-compose -f docker-compose.cytomine.yml up -d
docker-compose -f docker-compose.wizard.yml up -d
docker-compose -f docker-compose.compare.yml up -d