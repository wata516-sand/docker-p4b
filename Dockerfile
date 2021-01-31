FROM ubuntu:18.04

ENV P4TRUST=/p4/config/.p4trust \
    P4TICKETS=/p4/config/.p4tickets

RUN apt-get update
RUN apt-get install -y wget
RUN apt-get install -y gnupg
RUN apt-get install -y openssl

RUN echo deb http://package.perforce.com/apt/ubuntu bionic release> /etc/apt/sources.list.d/perforce.list
RUN wget -qO - https://package.perforce.com/perforce.pubkey | apt-key add -

RUN apt-get update
RUN apt-get install -y helix-broker

EXPOSE 1668

RUN mkdir -p /p4b/ssl && \
    mkdir -p /p4b/config && \
    mkdir -p /p4b/logs

VOLUME [ "/p4b/ssl", "/p4b/config", "/p4b/logs" ]

ADD ./run.sh /
CMD ["/run.sh"]
