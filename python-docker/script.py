from python_on_whales import DockerClient

docker = DockerClient(compose_files=["./docker-compose.yml"])
docker.compose.up()
