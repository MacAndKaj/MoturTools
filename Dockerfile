FROM ubuntu:jammy

# ARGUMENTS
ARG GH_SSH_KEY

# ENV VARIABLES
ENV DEV_PATH=/home/devel

WORKDIR ${DEV_PATH}

# PACKAGES CONFIGURATION
RUN apt-get -y update  

RUN apt-get install -y --no-install-recommends \
        gcc \
        cmake \
        make \
        wget \
        git \
        unzip \ 
        ssh \
        build-essential \
        pkg-config \
        tar \
        locales \
        locales-all \
        vim \
        apt-transport-https \
        ca-certificates \
    && apt-get clean

# SSH CONFIGURATION
RUN mkdir /root/.ssh/

COPY ${GH_SSH_KEY} /root/.ssh/id_rsa 

RUN chmod 600 /root/.ssh/id_rsa

RUN touch /root/.ssh/known_hosts && ssh-keyscan -H github.com >> ~/.ssh/known_hosts

# ADDITIONAL SETUP
RUN update-ca-certificates