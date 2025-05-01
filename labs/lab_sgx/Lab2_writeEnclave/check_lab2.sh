#!/bin/bash

echo "===== SGX Environment Check ====="

echo -n "[1] SDK Environment: "
if [[ -n "$SGX_SDK" ]]; then
    echo "Detected at $SGX_SDK"
else
    echo "Not sourced. Run: source ~/Projects/HSS/labs/sgx_lab/sgxsdk/environment"
fi

echo -n "[2] SGX Hardware Support: "
if grep -qw sgx /proc/cpuinfo; then
    echo "Supported"
else
    echo "NOT supported (simulation only)"
fi

echo "[3] Checking output files:"
for file in Bonus_DigitalWallet.txt Lab2_WriteEnclave.txt Bonus_Hardware_1.txt Bonus_Hardware_2.txt; do
    if [[ -f "$file" ]]; then
        echo " - Found: $file"
    else
        echo " - Missing: $file"
    fi
done

echo "[4] Suggest: Run './secure_rng' to reconfirm output if needed."

