FROM ubuntu:jammy

# ARGUMENTS
ARG GH_SSH_KEY

# ENV VARIABLES
ENV DEV_PATH=/home/devel

WORKDIR ${DEV_PATH}

# SSH CONFIGURATION
RUN mkdir /root/.ssh/

COPY ${GH_SSH_KEY} /root/.ssh/id_rsa 

RUN chmod 600 /root/.ssh/id_rsa

RUN touch /root/.ssh/known_hosts

# PACKAGES CONFIGURATION
RUN apt-get -y update  

RUN apt-get -y install \
        gcc \
        cmake \
        make \
        wget \
        git \
        unzip

RUN apt-get -y install arm-none-eabi*


# TOOLCHAIN CONFIGURATION
RUN cd ${DEV_PATH}

RUN wget https://github.com/STMicroelectronics/STM32CubeF0/archive/refs/tags/v1.11.3.zip  \
        && unzip -q /home/devel/v1.11.3.zip

