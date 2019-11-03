# docker-xpra
Ubuntu container with Xpra for running remote desktop applications in browser.

Image is built from NVIDIA Docker image and is compatible with GPUs - need to install additional software.

```
docker run -it -p 9876:9876 tswetnam/xpra:bionic 
```

```
docker run -it -p 9876:9876 tswetnam/xpra:bionic xpra start --bind-tcp=0.0.0.0:9876 --html=on --start-child=xterm --exit-with-children --daemon=no
```

#### Run with NVIDIA GPU

```
docker run -it --gpus all -p 9876:9876 tswetnam/xpra:bionic xpra start --bind-tcp=0.0.0.0:9876 --html=on --start-child=xterm --exit-with-children --daemon=no --video-encoders=nvenc
```
