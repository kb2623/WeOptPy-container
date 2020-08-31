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
# Add env variables
echo 'export DEV_PKGS=g++ gcc cmake git openssh-client' >> $SINGULARITY_ENVIRONMENT
echo 'export LIB_PKGS=libc6-dev libssl-dev libcurl4-openssl-dev' >> $SINGULARITY_ENVIRONMENT
echo 'export PRG_PKGS=curl make bash ca-certificates' >> $SINGULARITY_ENVIRONMENT

# Install build tools and tools
apt update
apt install --no-install-recommends -y "${DEV_PKGS}" "${LIB_PKGS}" "${PRG_PKGS}"

# Build spse and install
cd /opt/WeOptPy
make build install

# Clean
cd /tmp && rm -rf /tmp/spse
apt remove -y ${DEV_PKGS} && apt autoremove -y

%environment
export LISTEN_PORT=12345
export LC_ALL=C

%runscript
echo "This is what happens when you run the container..."


