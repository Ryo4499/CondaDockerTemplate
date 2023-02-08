FROM nvidia/cuda:11.8.0-devel-ubuntu20.04
ARG HOST_UID
ARG HOST_GID
ARG MY_USER
ARG MY_GROUP
ARG TZ

ENV TZ $TZ
ENV DEBIAN_FRONTEND noninteractive

RUN groupadd -g $HOST_GID $MY_GROUP && \
    useradd -G $MY_GROUP -g $HOST_GID -u $HOST_UID $MY_USER && \
    apt-get update && \
    apt-get install -y wget software-properties-common tzdata

USER $MY_USER
WORKDIR "/home/$MY_USER"

RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
    bash Miniconda3-latest-Linux-x86_64.sh -b -p ~/.local/miniconda3 && \
    rm -r Miniconda3-latest-Linux-x86_64.sh

ENV PATH ~/.local/miniconda3/bin:$PATH

ENV CONDA_DEFAULT_ENV myenv && \
    PATH ~/.local/conda/envs/myenv/bin:$PATH

RUN bash -c "conda update -n base -c defaults conda" && \
    bash -c "conda create -n myenv" && \
    bash -c "conda init bash" && \
    echo "conda activate myenv" >> ~/.bashrc
