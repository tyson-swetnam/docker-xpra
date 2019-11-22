FROM tswetnam/xpra:bionic
USER root
ENV SHELL /bin/bash
RUN apt-get update && apt-get install -y sshfs
