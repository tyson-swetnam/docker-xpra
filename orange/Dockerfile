FROM tswetnam/xpra:20.04

USER root

# Install Python and linux depends
RUN apt-get update \
    && apt-get install -y bzip2 g++ virtualenv build-essential \
    git software-properties-common sudo 

# Install Orange3
RUN conda install orange3
RUN conda install -c defaults pyqt=5 qt


# Create Orange user
ENV USER orange
ENV PASSWORD orange
ENV HOME /home/orange
RUN useradd -m -s /bin/bash orange
RUN echo orange:orange | chpasswd
RUN gpasswd -a orange sudo

ADD ./icons/orange.png /usr/share/backgrounds/images/orange.png
ADD ./icons/orange.png .conda/share/orange3/orange.png
ADD ./orange/orange-canvas.desktop Desktop/orange-canvas.desktop

USER orange
WORKDIR /home/orange

# Start Orange
CMD xpra start --bind-tcp=0.0.0.0:9876 --html=on --start-child="python3 -m Orange.canvas"  --exit-with-children=no --daemon=no --xvfb="/usr/bin/Xvfb +extension Composite -screen 0 1920x1080x24+32 -nolisten tcp -noreset" --file-transfer=on --pulseaudio=no --notifications=no --bell=no :100
