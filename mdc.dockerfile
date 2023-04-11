FROM ubuntu:jammy

# ARGUMENTS
ARG GH_SSH_KEY
ARG STM32CUBEF0_VERSION

# ENV VARIABLES
ENV DEV_PATH=/home/devel
ENV STM32F0_PATH=${DEV_PATH}/STM32CubeF0

WORKDIR ${DEV_PATH}

# PACKAGES CONFIGURATION
RUN apt-get -y update  

RUN apt-get -y install \
        gcc \
        cmake \
        make \
        wget \
        git \
        unzip \ 
        ssh

# SSH CONFIGURATION
RUN mkdir /root/.ssh/

COPY ${GH_SSH_KEY} /root/.ssh/id_rsa 

RUN chmod 600 /root/.ssh/id_rsa

RUN touch /root/.ssh/known_hosts && ssh-keyscan -H github.com >> ~/.ssh/known_hosts

# TOOLCHAIN CONFIGURATION
RUN cd ${DEV_PATH}

RUN apt-get -y install arm-none-eabi*

RUN git clone --depth 1 --branch ${STM32CUBEF0_VERSION} git@github.com:STMicroelectronics/STM32CubeF0.git
