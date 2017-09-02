FROM ubuntu:17.04

RUN apt-get update
apt-get install -y \
    build-essential \
    cscope \
    curl \
    gdebi-core \
    git \
    inetutils-traceroute \
    iputils-ping \
    netcat \ 
    perl \
    pwgen \
    python3-software-properties \
    realpath \
    rsync \
    software-properties-common \
    vim-gnome \
    wget
RUN apt-get update && apt-get build-dep -y shotwell

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
WORKDIR /root
COPY ./entrypoint.sh /entrypoint.sh

CMD ["/entrypoint.sh"]
