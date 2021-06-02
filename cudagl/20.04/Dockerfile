# Dockerfile modified to bionic from https://github.com/lanrat/docker-xpra-html5
FROM nvcr.io/nvidia/cudagl:11.2.2-runtime-ubuntu20.04

# Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE
ARG VCS_REF
ARG VERSION
LABEL org.label-schema.build-date=$BUILD_DATE \
    org.label-schema.name="CyVerse XPRA CUDAGL" \
    org.label-schema.description="XPRA Remote Desktop, additional depends for CyVerse K8s workbench" \
    org.label-schema.url="https://cyverse.org" \
    org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.vcs-url="e.g. https://github.com/cyverse-vice/xpra" \
    org.label-schema.vendor="CyVerse" \
    org.label-schema.version=$VERSION \
    org.label-schema.schema-version="1.0.0"

# install XPRA: https://xpra.org/trac/wiki/Usage/Docker 
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y wget \
    gnupg2 \ 
    apt-transport-https && \
    wget -O - https://xpra.org/gpg.asc | apt-key add - && \
    echo "deb https://xpra.org/ focal main" > /etc/apt/sources.list.d/xpra.list

RUN apt-get update && \
    apt-get install -y xpra \
    xvfb \
    xterm \
    sshfs && \
    apt-get clean && \ 
    rm -rf /var/lib/apt/lists/*

RUN apt-key list
    
# Add sudo to user
RUN adduser --disabled-password --gecos "VICE_User" --uid 1000 user
RUN apt-get update && apt-get install -y sudo
RUN usermod -aG sudo user
RUN echo 'ALL ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers


# install all X apps here
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive && \
    apt-get clean && \ 
    rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y apt-utils \
    build-essential \
    firefox \
    gdm3 \
    glances \
    glmark2 \
    gnome-shell \
    gnome-session \
    gnome-terminal \
    htop \
    libqt5x11extras5 \
    linux-generic-hwe-18.04-edge \
    nautilus \
    seahorse-nautilus \
    software-properties-common \
    tasksel

RUN mkdir -p /run/user/1000/xpra
RUN mkdir -p /run/xpra
RUN chown user:user /run/user/1000/xpra
RUN chown -R user:user /run/xpra
RUN chown -R user:user /run/user

# Install CyberDuck CLI
RUN echo "deb https://s3.amazonaws.com/repo.deb.cyberduck.io stable main" | tee /etc/apt/sources.list.d/cyberduck.list > /dev/null && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys FE7097963FEFBE72 && \
    apt-get update && \
    apt-get install duck

# Install Go
RUN wget -c https://dl.google.com/go/go1.16.4.linux-amd64.tar.gz -O - | sudo tar -xz -C /usr/local

# iRODS iCommands kludge
RUN wget -qO - https://packages.irods.org/irods-signing-key.asc | apt-key add - && \
    echo "deb [arch=amd64] https://packages.irods.org/apt/ bionic  main" > /etc/apt/sources.list.d/renci-irods.list && \
    apt-get update && \
    wget -c \
    http://security.ubuntu.com/ubuntu/pool/main/p/python-urllib3/python-urllib3_1.22-1ubuntu0.18.04.2_all.deb \
    http://security.ubuntu.com/ubuntu/pool/main/r/requests/python-requests_2.18.4-2ubuntu0.1_all.deb \
    http://security.ubuntu.com/ubuntu/pool/main/o/openssl1.0/libssl1.0.0_1.0.2n-1ubuntu5.6_amd64.deb && \
    apt install -y \
    ./python-urllib3_1.22-1ubuntu0.18.04.2_all.deb \
    ./python-requests_2.18.4-2ubuntu0.1_all.deb \
    ./libssl1.0.0_1.0.2n-1ubuntu5.6_amd64.deb && \
    rm -rf \
    ./python-urllib3_1.22-1ubuntu0.18.04.2_all.deb \
    ./python-requests_2.18.4-2ubuntu0.1_all.deb \
    ./libssl1.0.0_1.0.2n-1ubuntu5.6_amd64.deb

RUN apt install -y irods-icommands

# Install VirtualGL for testing
RUN cd /tmp && wget https://sourceforge.net/projects/virtualgl/files/2.6.3/virtualgl_2.6.3_amd64.deb/download -O virtualgl_2.6.3_amd64.deb && \
    dpkg -i --force-depends virtualgl_2.6.3_amd64.deb && \
    apt-get -f install && \
    rm -rf /tmp/*.deb

# add some viz permissions for VirtualGL
RUN chown -R user:user /run/user
RUN apt-get update && apt-get install -y libxcb-xinerama0


RUN apt-get install -y language-pack-en-base && \ 
    locale-gen en_US.UTF-8 && \ 
    update-locale LANG=en_US.UTF-8

RUN echo LANG="en_US.UTF-8" > /etc/default/locale
RUN echo en_US.UTF-8 UTF-8 >> /etc/locale.gen && locale-gen

ENV TZ America/Phoenix
ENV LC_ALL "en_US.UTF-8"

# Install MiniConda and Tini

ENV TZ=US/Phoenix
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV PATH /opt/conda/bin:$PATH

RUN apt-get update --fix-missing && apt-get install -y wget bzip2 ca-certificates \
    libglib2.0-0 libxext6 libsm6 libxrender1 \
    git mercurial subversion

RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /opt/conda && \
    rm ~/miniconda.sh && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc

RUN apt-get install -y curl grep sed dpkg && \
    TINI_VERSION=`curl https://github.com/krallin/tini/releases/latest | grep -o "/v.*\"" | sed 's:^..\(.*\).$:\1:'` && \
    curl -L "https://github.com/krallin/tini/releases/download/v${TINI_VERSION}/tini_${TINI_VERSION}.deb" > tini.deb && \
    dpkg -i tini.deb && \
    rm tini.deb && \
    apt-get clean

RUN chown -R user:user /opt/conda

USER user

RUN echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc

# add iRODS iCommands to user profile as JSON
RUN mkdir /home/user/.irods && echo '{"irods_host": "data.cyverse.org", "irods_port": 1247, "irods_user_name": "$IPLANT_USER", "irods_zone_name": "iplant"}' | tee  > /home/user/.irods/irods_environment.json

# Set some environment stuff
ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES graphics,utility,compute

ENV PATH=$PATH:/opt/VirtualGL/bin/:/usr/local/go/bin 

ENV DISPLAY=:100

WORKDIR /home/user
VOLUME /tmp/.X11-unix
EXPOSE 9876

CMD xpra start --bind-tcp=0.0.0.0:9876 --html=on --start-child=gnome-terminal --exit-with-children=no --daemon=no --xvfb="/usr/bin/Xvfb +extension Composite -screen 0 1920x1080x24+32 -nolisten tcp -noreset" --pulseaudio=no --notifications=no --bell=no :100
