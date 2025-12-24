#!/bin/bash
echo "Installing Magisk App (APK) - Robust Method..."

# Download fresh APK
curl -L -o Magisk.apk "https://github.com/topjohnwu/Magisk/releases/download/v26.4/Magisk-v26.4.apk"

# Installation Loop: Retry up to 5 times
INSTALLED=false
for i in 1 2 3 4 5; do
    echo "Attempt $i: Installing Magisk..."
    # Wait for boot completion
    adb wait-for-device shell 'while [[ -z $(getprop sys.boot_completed) ]]; do sleep 1; done;'
    
    if adb install -r Magisk.apk; then
        echo "Magisk Installed Successfully!"
        INSTALLED=true
        break
    else
        echo "Install failed, retrying in 5 seconds..."
        sleep 5
    fi
done

if [ "$INSTALLED" = false ]; then
    echo "CRITICAL WARNING: Magisk App failed to install after 5 attempts."
    exit 1
fi

echo "Enabling Root Access (ADB)..."
adb root
adb wait-for-device
