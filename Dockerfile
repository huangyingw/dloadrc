FROM ubuntu:17.10
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get install -y \
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
    ssh \
    vim-gnome \
    wget

COPY ./.ssh/ /root/.ssh/
RUN chmod 400 /root/.ssh/id_rsa
RUN git clone -b master git@bitbucket.org:huangyingw/loadrc.git /root/loadrc
RUN /root/loadrc/setup.sh

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Vim wrapper
COPY run /usr/local/bin/

ENTRYPOINT ["sh", "/usr/local/bin/run"]
