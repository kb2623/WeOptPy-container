FROM python:3.8-slim-buster

LABEL maintainer="Klemen Berkovic <klemen.berkovic1@um.si>"
LABEL description="Debian 10 (buster) image for compute server."

ENV PATH $PATH:/usr/local/bin
ENV LANG C.UTF-8
ENV DEV_PKG="g++ gcc cmake git openssh-client"
ENV LIB_PKG="libc6-dev libssl-dev libcurl4-openssl-dev"
ENV RUN_PKG="curl make bash ca-certificates"

# Install additional programs
RUN apt update \
 && apt install -y --no-install-recommends ${DEV_PKG} ${LIB_PKG} ${RUN_PKG}

# Add starter sript
COPY WeOptPy /opt/WeOptPy

# BUILD WeOptPy
RUN cd /opt/WeOptPy \
 && make build install

# Clean
RUN rm -rf /tmp/spse \
 && apt remove -y ${DEV_PKG} \
 && apt autoremove -y

