FROM ubuntu:16.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
    && apt install -y software-properties-common \
    && add-apt-repository -y ppa:bladerf/bladerf \
    && add-apt-repository -y ppa:myriadrf/drivers \
    && add-apt-repository -y ppa:myriadrf/gnuradio \
    && add-apt-repository -y ppa:gqrx/gqrx-sdr \
    && apt-get update \
    && apt upgrade -yf

RUN apt-get install -y gqrx-sdr libvolk1-bin

COPY pulse-client.conf /etc/pulse/client.conf

RUN sed -i "s/enable-shm = yes/enable-shm = no/" /etc/pulse/daemon.conf

RUN apt-get -y clean && apt-get -y autoremove \
    && rm -rf /var/lib/apt/lists/*

ENV UNAME gqrx

RUN export UNAME=$UNAME UID=1000 GID=1000 && \
    mkdir -p "/home/${UNAME}" && \
    echo "${UNAME}:x:${UID}:${GID}:${UNAME} User,,,:/home/${UNAME}:/bin/bash" >> /etc/passwd && \
    echo "${UNAME}:x:${UID}:" >> /etc/group && \
    mkdir -p /etc/sudoers.d && \
    echo "${UNAME} ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/${UNAME} && \
    chmod 0440 /etc/sudoers.d/${UNAME} && \
    chown ${UID}:${GID} -R /home/${UNAME} && \
    gpasswd -a ${UNAME} audio

ENV HOME /home/${UNAME}

USER $UNAME

COPY gqrx.conf ${HOME}/.config/gqrx/default.conf

WORKDIR /home/${UNAME}

RUN volk_profile

ENTRYPOINT [ "gqrx" ]