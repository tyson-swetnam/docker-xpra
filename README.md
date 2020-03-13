
image            | description                               | size   | metrics | build status 
---------------- | ----------------------------------------- | ------ | ------- | --------------
[![DockerHub](https://img.shields.io/badge/DockerHub-brightgreen.svg?style=popout&logo=Docker)](https://hub.docker.com/r/tswetnam/xpra)  | Xpra NVIDIA OpenGL Ubuntu 18.04 base | [![](https://images.microbadger.com/badges/image/tswetnam/xpra.svg)](https://microbadger.com/images/tswetnam/xpra) | [![](https://img.shields.io/docker/pulls/tswetnam/xpra.svg)](https://hub.docker.com/r/tswetnam/xpra)  |  [![](https://img.shields.io/docker/automated/tswetnam/xpra.svg)](https://hub.docker.com/r/tswetnam/xpra/builds)



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

```
docker run --gpus all --rm -it -p 9876:9876 -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY -e XAUTHORITY -e NVIDIA_DRIVER_CAPABILITIES=all tswetnam/xpra:bionic
```
