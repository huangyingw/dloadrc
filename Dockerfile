FROM ubuntu:17.04

# User config
ENV UID="1000" \
    UNAME="developer" \
    GID="1000" \
    GNAME="developer" \
    SHELL="/bin/bash" \
    UHOME=/home/developer

# User
# Create HOME dir
RUN mkdir -p "${UHOME}" \
    && chown "${UID}":"${GID}" "${UHOME}" \
# Create user
    && echo "${UNAME}:x:${UID}:${GID}:${UNAME},,,:${UHOME}:${SHELL}" \
    >> /etc/passwd \
    && echo "${UNAME}::17032:0:99999:7:::" \
    >> /etc/shadow \
# Create group
    && echo "${GNAME}:x:${GID}:${UNAME}" \
    >> /etc/group

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
    vim-gnome \
    wget

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Vim wrapper
COPY run /usr/local/bin/
#custom .vimrc stub
RUN mkdir -p /ext  && echo " " > /ext/.vimrc
USER $UNAME

ENTRYPOINT ["sh", "/usr/local/bin/run"]
