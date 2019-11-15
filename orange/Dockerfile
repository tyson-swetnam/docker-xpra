FROM tswetnam/xpra:bionic

# conda install requires bzip
RUN apt-get update && apt-get install -y python3-pip python3-dev python-virtualenv bzip2 g++ git sudo 
RUN apt-get install -y xfce4-terminal software-properties-common python-numpy

ENV USER orange
ENV PASSWORD orange
ENV HOME /home/${USER}
ENV CONDA_DIR /home/${USER}/.conda

RUN useradd -m -s /bin/bash ${USER}
RUN echo "${USER}:${PASSWORD}" | chpasswd
RUN gpasswd -a ${USER} sudo

USER orange
WORKDIR ${HOME}

RUN wget -q https://repo.continuum.io/archive/Anaconda3-5.3.1-Linux-x86_64.sh -O anaconda.sh
RUN bash anaconda.sh -b -p ~/.conda && rm anaconda.sh
RUN $CONDA_DIR/bin/conda create python=3.6 --name orange3
RUN $CONDA_DIR/bin/conda config --add channels conda-forge
RUN bash -c "source $CONDA_DIR/bin/activate orange3 && $CONDA_DIR/bin/conda install orange3"
RUN echo 'export PATH=~/.conda/bin:$PATH' >> /home/orange/.bashrc
RUN bash -c "source $CONDA_DIR/bin/activate orange3 && pip install Orange3-Text Orange3-ImageAnalytics Orange3-Network Orange-Bioinformatics"

WORKDIR /home/orange

RUN bash -c "source $CONDA_DIR/bin/activate orange3"

ENTRYPOINT "python -m Orange.canvas"
