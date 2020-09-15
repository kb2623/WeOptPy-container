# Python and Alpine linux version
ARG PYTHON_VERSION=3.7
ARG ALPINE_VERSION=3.10

FROM python:${PYTHON_VERSION}-alpine${ALPINE_VERSION}

LABEL maintainer="Klemen Berkovic <klemen.berkovic1@um.si>"
LABEL description="Debian 10 (buster) image for compute server."

ARG USER_ID=1000
ARG GROUP_ID=1000

ENV PATH $PATH:/usr/local/bin
ENV LANG C.UTF-8

# Install additional programs
RUN apk add --no-cache --virtual .progs-deps make bash \
 && apk add --no-cache --virtual .build-deps gcc g++ gfortran linux-headers libc-dev musl-dev libffi-dev lapack-dev
# Install pipenv
RUN pip install --upgrade pip \ 
 && pip install pipenv

# Add starter sript
COPY WeOptPy /opt/WeOptPy

# BUILD WeOptPy
RUN make -C /opt/WeOptPy build \
 && pip install --compile /opt/WeOptPy/dist/WeOptPy*.whl

# Create user
RUN addgroup -g ${GROUP_ID} -S weoptpy \
 && adduser -S -D -H -u ${USER_ID} -h /home/weoptpy -s /bin/sh -G weoptpy -g weoptpy weoptpy

RUN apk del .build-deps

USER weoptpy
WORKDIR /home/weoptpy

ENTRYPOINT bash

