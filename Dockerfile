FROM nvidia/cuda:11.8.0-devel-ubuntu20.04

ARG HOST_UID=1000
ARG HOST_GID=1000
ARG HOST_USER='user'
ARG HOST_GROUP='user'
ARG TZ='Etc/UTC'

ENV TZ $TZ
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    apt-get install -y wget software-properties-common tzdata zsh && \
    groupadd -g $HOST_GID $HOST_GROUP && \
    useradd -G $HOST_GROUP -g $HOST_GID -u $HOST_UID -s /bin/zsh $HOST_USER && \
    echo $TZ > /etc/timezone && \
    ln -sf /usr/share/zoneinfo/$TZ /etc/localtime

USER $HOST_USER
WORKDIR "/home/$HOST_USER"

RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
    bash Miniconda3-latest-Linux-x86_64.sh -b -p ~/.local/miniconda3 && \
    rm -r Miniconda3-latest-Linux-x86_64.sh

ENV PATH ~/.local/miniconda3/bin:$PATH

ENV CONDA_DEFAULT_ENV myenv && \
    PATH ~/.local/conda/envs/myenv/bin:$PATH

RUN zsh -c "conda update -n base -c defaults conda" && \
    zsh -c "conda create -n myenv" && \
    zsh -c "conda init bash" && \
    echo "conda activate myenv" >> ~/.bashrc
