#!/bin/bash

set -e

echo "========== [Lab 2 Setup: Intel SGX Simulation + Bonus] =========="

# 1. Detect Ubuntu version
echo "[+] Checking Ubuntu version..."
. /etc/os-release
echo "[INFO] Ubuntu $VERSION_ID detected"

# 2. Install dependencies
echo "[+] Installing required packages..."
sudo apt-get update
sudo apt-get install -y build-essential ocaml ocamlbuild automake autoconf libtool \
wget python-is-python3 libssl-dev git cmake perl unzip

# 3. Set up SGX Lab Directory
echo "[+] Creating SGX lab folder: sgx_lab"
mkdir -p ~/Projects/HSS/labs/sgx_lab && cd ~/Projects/HSS/labs/sgx_lab

# 4. Clone and build Intel SGX SDK
echo "[+] Cloning Intel SGX SDK repo..."
git clone https://github.com/intel/linux-sgx.git
cd linux-sgx

echo "[+] Running make preparation..."
make preparation

# Optional tool setup for Ubuntu 20.04
if [[ "$VERSION_ID" == "20.04" ]]; then
    echo "[+] Copying mitigation tools for Ubuntu 20.04..."
    sudo cp external/toolset/ubuntu20.04/* /usr/local/bin
    sudo chmod +x /usr/local/bin/*
fi

echo "[+] Building SDK installer..."
make sdk_install_pkg

INSTALLER=$(find ./linux/installer/bin -name "sgx_linux_x64_sdk_*.bin" | head -n 1)

if [[ -z "$INSTALLER" ]]; then
    echo "[ERROR] SGX SDK installer not found!"
    exit 1
fi

echo "[+] Installing SGX SDK..."
chmod +x "$INSTALLER"
"$INSTALLER" --prefix ~/Projects/HSS/labs/sgx_lab

# 5. Set environment variables
source ~/Projects/HSS/labs/sgx_lab/sgxsdk/environment

# 6. Extract provided SGX Lab code
echo "[+] Extracting lab_sgx.zip..."
cd ~/Projects/HSS/labs
unzip -o lab_sgx.zip

# 7. Final reminder
echo -e "\n[✓] Setup Complete!"
echo -e "[INFO] SGX environment is ready (Simulation Mode)."
echo -e "[INFO] Now go to: Lab1_HelloEnclave/, Lab2_WriteEnclave/, or SampleEnclave/ to compile.\n"
echo -e "    e.g., cd Lab1_HelloEnclave && make SGX_MODE=SIM && ./app"
echo -e "          cd Lab2_WriteEnclave/SampleEnclave && make SGX_MODE=SIM && ./secure_rng"
echo -e "          (For bonus digital wallet: edit ECALLs and recompile)\n"

