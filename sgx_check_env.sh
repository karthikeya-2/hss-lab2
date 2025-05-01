#!/bin/bash

echo "==== SYSTEM INFO ===="
uname -a
lsb_release -a

echo -e "\n==== GCC VERSION ===="
gcc --version

echo -e "\n==== MAKE VERSION ===="
make --version

echo -e "\n==== PKG-CONFIG CHECK ===="
pkg-config --version 2>/dev/null || echo "pkg-config not installed"

echo -e "\n==== SGX SDK ENVIRONMENT ===="
echo "SGX_SDK = $SGX_SDK"
echo "Checking if 'sgx_edger8r' is available..."
command -v sgx_edger8r || echo "sgx_edger8r not found in PATH"

echo -e "\n==== SGX LIBRARIES ===="
ldconfig -p | grep sgx || echo "No SGX libraries found via ldconfig"

echo -e "\n==== COMMON BUILD TOOLS ===="
for tool in git make gcc g++ cmake python3 pip3; do
    printf "%-10s: " "$tool"
    command -v $tool >/dev/null && echo "installed" || echo "missing"
done

echo -e "\n==== SGX DEVICE CHECK ===="
ls /dev/isgx 2>/dev/null && echo "/dev/isgx exists" || echo "/dev/isgx missing (simulation-only or driver not loaded)"

