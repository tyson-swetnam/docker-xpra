FROM tswetnam/xpra:bionic

USER root

# Install Python and linux depends
RUN apt-get update \
    && apt-get install -y bzip2 g++ virtualenv build-essential \
    git python3-pip python3-dev python3-virtualenv \
    python3-pip python3-numpy software-properties-common

# Install Qt dependencies for the GUI
RUN pip3 install PyQt5 PyQtWebEngine

# Install Orange3
RUN pip3 install orange3 Orange3-Text Orange3-ImageAnalytics Orange3-Network Orange-Bioinformatics

# Create Orange user
ENV USER orange
ENV PASSWORD orange
ENV HOME /home/${USER}
RUN useradd -m -s /bin/bash ${USER}
RUN echo "${USER}:${PASSWORD}" | chpasswd
#RUN gpasswd -a ${USER} sudo

#ADD ./icons/orange.png /usr/share/backgrounds/images/orange.png
#ADD ./icons/orange.png .conda/share/orange3/orange.png
#ADD ./orange/orange-canvas.desktop Desktop/orange-canvas.desktop

USER orange
WORKDIR ${HOME}

# Create a separate Python environment for Orange and its dependencies ...
ENV VIRTUAL_ENV=/home/orange/orange3venv
RUN python3 -m virtualenv --python=python3 --system-site-packages $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

# ... and make it the active one
ENV source $VIRTUAL_ENV/bin/activate

# Start Orange
CMD xpra start --bind-tcp=0.0.0.0:9876 --html=on --start-child="python -m Orange.canvas"  --exit-with-children=no --daemon=no --xvfb="/usr/bin/Xvfb +extension Composite -screen 0 1920x1080x24+32 -nolisten tcp -noreset" --pulseaudio=no --notifications=no --bell=no :100
