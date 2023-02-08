FROM nvidia/cuda:11.8.0-devel-ubuntu20.04
ARG UID
ARG GID
ARG USER
ARG GROUP
ARG TZ
ENV DEBIAN_FRONTEND noninteractive

RUN groupadd -g $GID $GROUP && useradd -G $GROUP -g $GID -u $UID $USER
RUN apt-get update && apt-get install -y wget software-properties-common tzdata

USER $USER
WORKDIR "/home/$USER"

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

RUN unset UID GID GROUP
ENV TZ $TZ
