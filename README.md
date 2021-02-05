[![Project Supported by CyVerse](https://img.shields.io/badge/Supported%20by-CyVerse-blue.svg)](https://learning.cyverse.org/projects/vice/en/latest/) [![Project Status: Active – The project has reached a stable, usable state and is being actively developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active) [![license](https://img.shields.io/badge/license-GPLv3-blue.svg)](https://opensource.org/licenses/GPL-3.0)

| image | description | name:tag | base image |
|-------|-------------|----------|------------|
[![DockerHub](https://img.shields.io/badge/DockerHub-brightgreen.svg?style=popout&logo=Docker)](https://hub.docker.com/r/tswetnam/xpra)  | Xpra NVIDIA OpenGL Ubuntu 18.04 base | tswetnam/xpra | 18.04  | [nvidia/opengl:1.2-glvnd-runtime-ubuntu18.04](https://ngc.nvidia.com/catalog/containers/nvidia:cudagl/tags)
[![DockerHub](https://img.shields.io/badge/DockerHub-brightgreen.svg?style=popout&logo=Docker)](https://hub.docker.com/r/tswetnam/xpra)  | Xpra NVIDIA OpenGL Ubuntu 20.04 base | tswetnam/xpra | 20.04  | [nvidia/opengl:1.2-glvnd-runtime-ubuntu20.04](https://ngc.nvidia.com/catalog/containers/nvidia:cudagl/tags)
[![DockerHub](https://img.shields.io/badge/DockerHub-brightgreen.svg?style=popout&logo=Docker)](https://hub.docker.com/r/tswetnam/xpra)  | Xpra NVIDIA CUDA + OpenGL Ubuntu 18.04 base | tswetnam/xpra | cudagl-18.04  | [nvcr.io/nvidia/cudagl:11.2.0-runtime-ubuntu18.04](https://ngc.nvidia.com/catalog/containers/nvidia:cudagl/tags)
[![DockerHub](https://img.shields.io/badge/DockerHub-brightgreen.svg?style=popout&logo=Docker)](https://hub.docker.com/r/tswetnam/xpra)  | Xpra NVIDIA CUDA + OpenGL Ubuntu 20.04 base | tswetnam/xpra | cudagl-20.04  | [nvcr.io/nvidia/cudagl:11.2.0-runtime-ubuntu20.04](https://ngc.nvidia.com/catalog/containers/nvidia:cudagl/tags)

# docker-xpra
Ubuntu container with Xpra for running remote desktop applications in browser.

Image is built from NVIDIA Docker image and is compatible with GPUs - need to install additional software.

```
docker run -it -p 9876:9876 tswetnam/xpra:bionic 
```

With a new `ENTRYPOINT`:

```
docker run -it -p 9876:9876 tswetnam/xpra:bionic xpra start --bind-tcp=0.0.0.0:9876 --html=on --start-child=xterm --exit-with-children --daemon=no
```

#### Run with NVIDIA GPU

You need to have an [xorg]() server running prior to launching. 

```
export DISPLAY=:0
docker run --gpus all --rm -it -p 9876:9876 -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY -e XAUTHORITY -e QT_X11_NO_MITSHM=1 -e NVIDIA_DRIVER_CAPABILITIES=all tswetnam/xpra:cudagl-18.04
```
