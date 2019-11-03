# Dockerfile modified to bionic from https://github.com/lanrat/docker-xpra-html5

FROM ubuntu:bionic
MAINTAINER Tyson Lee Swetnam <tswetnam@cyverse.org>

# install XPRA: https://xpra.org/trac/wiki/Usage/Docker 
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y wget && \
    wget -O - http://winswitch.org/gpg.asc | apt-key add - && \
    echo "deb http://winswitch.org/ bionic main" > /etc/apt/sources.list.d/xpra.list && \
    apt-get update &&
    DEBIAN_FRONTEND=noninteractive apt-get install -y xpra xvfb xterm && \
    apt-get clean && \ 
    rm -rf /var/lib/apt/lists/*
    
# non-root user
RUN adduser --disabled-password --gecos "VICE_User" --uid 1000 vice_user

# install all X apps here
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y firefox && \
    apt-get clean && \ 
    rm -rf /var/lib/apt/lists/*

USER user

ENV DISPLAY=:100

VOLUME /data

WORKDIR /home/vice_user

EXPOSE 10000

CMD xpra start --bind-tcp=0.0.0.0:9876 --html=on \
      --start-child=xterm --exit-with-children --daemon=no \
      --xvfb="/usr/bin/Xvfb +extension Composite -screen 0 1920x1080x24+32 -nolisten tcp -noreset" \
      --pulseaudio=no --notifications=no --bell=no
