# Dockerfile modified to bionic from https://github.com/lanrat/docker-xpra-html5
FROM nvcr.io/nvidia/cudagl:10.2-runtime-ubuntu18.04
MAINTAINER Tyson Lee Swetnam <tswetnam@cyverse.org>

# install XPRA: https://xpra.org/trac/wiki/Usage/Docker 
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y apt-utils software-properties-common curl \
    && curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | apt-key add -
RUN apt-get update && \
    apt-get install -y wget gnupg2 && \
    wget -O - http://winswitch.org/gpg.asc | apt-key add - && \
    echo "deb http://winswitch.org/ bionic main" > /etc/apt/sources.list.d/xpra.list && \
    apt-get update && \
    apt-get install -y xpra xvfb xterm && \
    apt-get clean && \ 
    rm -rf /var/lib/apt/lists/*
    
# non-root user
RUN adduser --disabled-password --gecos "VICE_User" --uid 1000 user

# install all X apps here
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y firefox && \
    apt-get clean && \ 
    rm -rf /var/lib/apt/lists/*

# Install Gnome 
RUN apt-get update && apt-get install -y software-properties-common \
    && add-apt-repository ppa:gnome3-team/gnome3 \
    && apt-get update && apt-get install -y gnome-shell ubuntu-gnome-desktop

# Install iCommands
RUN wget https://files.renci.org/pub/irods/releases/4.1.12/ubuntu14/irods-icommands-4.1.12-ubuntu14-x86_64.deb && \
    dpkg -i irods-icommands-4.1.12-ubuntu14-x86_64.deb && \
    rm irods-icommands-4.1.12-ubuntu14-x86_64.deb

# Install VirtualGL for testing
RUN cd /tmp && wget https://sourceforge.net/projects/virtualgl/files/2.6.3/virtualgl_2.6.3_amd64.deb/download -O virtualgl_2.6.3_amd64.deb && \
    dpkg -i --force-depends virtualgl_2.6.3_amd64.deb && \
    apt-get -f install && \
    rm -rf /tmp/*.deb

# Install NVIDIA drivers --experimental
<<<<<<< HEAD
#RUN add-apt-repository ppa:graphics-drivers/ppa && apt update \
#    && apt install -y nvidia-driver-450
=======

RUN add-apt-repository ppa:graphics-drivers/ppa && apt update \
    && apt install -y nvidia-driver-450
>>>>>>> f85e9cf6a796d143646851d2daf669b715d967dc

RUN mkdir -p /run/user/1000/xpra
RUN mkdir -p /run/xpra
RUN chown user:user /run/user/1000/xpra
RUN chown user:user /run/xpra
RUN apt-get install -y language-pack-en-base && \ 
    locale-gen en_US.UTF-8 && \ 
    update-locale LANG=en_US.UTF-8

RUN echo LANG="en_US.UTF-8" > /etc/default/locale
RUN echo en_US.UTF-8 UTF-8 >> /etc/locale.gen && locale-gen

ENV TZ America/Phoenix
ENV LC_ALL "en_US.UTF-8"

# Add monitoring tools
RUN apt-get install -y --install-recommends linux-generic-hwe-18.04-edge
RUN apt-get install -y htop glances glmark2

USER user
# Set some environment stuff
ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES graphics,utility,compute
ENV DISPLAY=:10
<<<<<<< HEAD
ENV PATH=$PATH:/opt/VirtualGL/bin/
=======
>>>>>>> f85e9cf6a796d143646851d2daf669b715d967dc

WORKDIR /home/user

VOLUME /tmp/.X11-unix

CMD xpra start :10 --video-encoders=nvenc --bind-tcp=0.0.0.0:9876 --html=on --start-child=xterm --exit-with-children=no --daemon=no --xvfb="/usr/bin/Xvfb +extension Composite -screen 0 1920x1080x24+32 -nolisten tcp -noreset" --pulseaudio=no --notifications=no --bell=no 
