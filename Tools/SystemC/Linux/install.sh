#!/bin/bash

# Exit on error
set -e

# Variables
SYSTEMC_VERSION="2.3.3"
SYSTEMC_TAR="systemc-${SYSTEMC_VERSION}.tar.gz"
SYSTEMC_URL="https://www.accellera.org/images/downloads/standards/systemc/${SYSTEMC_TAR}"

# Download
wget "${SYSTEMC_URL}"

# Extract
tar -xvf "${SYSTEMC_TAR}"

# Compile and install
cd "systemc-${SYSTEMC_VERSION}"
mkdir objdir
cd objdir
../configure
make
sudo make install

# Add the SYSTEMC_HOME environment variable
echo "export SYSTEMC_HOME=/usr/local/systemc-${SYSTEMC_VERSION}" >> ~/.bashrc

echo "SystemC successfully installed."
