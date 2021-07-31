FROM gitpod/workspace-full

ENV DOCKER_BUILDKIT=1
RUN mkdir -p /home/gitpod/.docker/cli-plugins
RUN wget https://github.com/docker/buildx/releases/download/v0.6.1/buildx-v0.6.1.linux-amd64 -O /home/gitpod/.docker/cli-plugins/docker-buildx
RUN chmod a+x /home/gitpod/.docker/cli-plugins/docker-buildx
