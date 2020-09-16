Bootstrap: docker
From: python:3.7-slim

%help
This is a demo container used to illustrate a def file that
uses all supported sections.

%labels
AUTHOR Klemen Berkovic <klemen.berkovic1@um.si>
DESCRIPTION Debian 10 (buster) image for compute server.

%files
WeOptPy /opt/WeOptPy

%post
apt update
apt install -y --no-install-recommends gcc g++ gfortran libc-dev liblapack-dev
apt install -y --no-install-recommends bash make
pip install --upgrade pip
pip install pipenv
make -C /opt/WeOptPy PIPENV_INSTALL_TIMEOUT=10000 PIPENV_TIMEOUT=100000 PIPENV_MAX_RETRIES=5 PIPENV_SKIP_LOCK=True PIPENV_NOSPIN=True build install
pip install --compile /opt/WeOptPy/dist/WeOptPy*.whl
apt purge -y gcc g++ gfortran libc-dev liblapack-dev
apt autoremove -y

%environment
export LANG=C.UTF-8
export PATH=$PATH:/usr/local/bin

%runscript
echo "Starting Singularity container for WeOptPy!!!"
bash "$@"

