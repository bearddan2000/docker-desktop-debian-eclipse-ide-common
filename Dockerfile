FROM debian

ARG DEBIAN_FRONTEND=noninteractive

ENV DISPLAY :0

ENV USERNAME developer

WORKDIR /app

RUN apt update \
    && apt install -y openjdk-17-jre-headless \
        libswt-gtk-4-java sudo \
        gcc make php

COPY bin .

RUN ln -s /app/eclipse-installer/eclipse-inst /bin/eclipse

# create and switch to a user
RUN echo "backus ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
RUN useradd --no-log-init --home-dir /home/$USERNAME --create-home --shell /bin/bash $USERNAME
RUN adduser $USERNAME sudo
USER $USERNAME

WORKDIR /home/$USERNAME

CMD "eclipse"