Bootstrap: docker
From: debian:10

%help
This is a demo container used to illustrate a def file that
uses all supported sections.

%labels
AUTHOR Klemen Berkovic <klemen.berkovic1@um.si>
DESCRIPTION Debian 10 (buster) image for compute server.

%files
WeOptPy /opt/WeOptPy

%post
# Install build tools and tools
apt update
apt install --no-install-recommends -y \
	g++ gcc cmake git openssh-client \
	libc6-dev libssl-dev libcurl4-openssl-dev \
	curl make bash ca-certificates

# Build spse and install
cd /opt/WeOptPy
make build install

# Clean
cd /tmp && rm -rf /tmp/spse
apt remove -y g++ gcc cmake git openssh-client
apt autoremove -y

%environment
export LISTEN_PORT=12345
export LC_ALL=C

%runscript
Spse1.4 help


