# Python and Alpine linux version
ARG PYTHON_VERSION=3.7

FROM python:${PYTHON_VERSION}-slim

LABEL maintainer="Klemen Berkovic <klemen.berkovic1@um.si>"
LABEL description="Debian image for compute server."

# User id and gropu id
ARG USER_ID=1000
ARG GROUP_ID=1000

# Environment settings
ENV PATH $PATH:/usr/local/bin
ENV LANG C.UTF-8
# Programs and librariys instaled
ENV build_deps="gcc g++ gfortran libc-dev liblapack-dev" 
ENV progs_deps="make bash"

# Install additional programs
RUN apt update \
 && apt install -y --no-install-recommends ${build_deps} \
 && apt install -y --no-install-recommends ${progs_deps}
# Install pipenv
RUN pip install --upgrade pip \ 
 && pip install pipenv

# Add starter sript
COPY WeOptPy /opt/WeOptPy

# BUILD WeOptPy
RUN make -C /opt/WeOptPy PIPENV_INSTALL_TIMEOUT=10000 PIPENV_TIMEOUT=100000 PIPENV_MAX_RETRIES=5 PIPENV_SKIP_LOCK=True PIPENV_NOSPIN=True build \
 && pip install --compile /opt/WeOptPy/dist/WeOptPy*.whl

# Create user
RUN groupadd --gid ${GROUP_ID} weoptpy \
 && useradd -m --home-dir /home/weoptpy --shell /bin/bash --uid ${USER_ID} --gid ${GROUP_ID} --password weoptpy weoptpy

RUN apt purge -y ${build_deps} \
 && apt autoremove -y

USER weoptpy
WORKDIR /home/weoptpy

ENTRYPOINT bash

