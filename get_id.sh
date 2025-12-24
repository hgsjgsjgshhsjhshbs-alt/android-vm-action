#!/bin/bash
echo "Waiting for AnyDesk ID to be generated (Loop)..."
ANYDESK_ID=""

# Try for up to 30 attempts (approx 3 minutes)
for i in $(seq 1 30); do
    # Method 1: system.conf
    ANYDESK_ID=$(adb shell "grep -oE 'ad.anynet.id=[0-9]+' /data/data/com.anydesk.anydeskandroid/files/system.conf 2>/dev/null" | cut -d= -f2)
    
    # Method 2: Logcat (fallback)
    if [ -z "$ANYDESK_ID" ]; then
            # Search for "AnyNetId" or similar in logs
            ANYDESK_ID=$(adb logcat -d | grep -oE "id=[0-9]{9,}" | head -n 1 | cut -d= -f2)
    fi
    
    if [ -n "$ANYDESK_ID" ]; then
        echo "ID Found: $ANYDESK_ID"
        break
    fi
    
    echo "ID not found yet... retrying ($i/30)"
    sleep 5
done

if [ -z "$ANYDESK_ID" ]; then
    echo "WARNING: Could not retrieve AnyDesk ID."
else
    echo "=========================================================="
    echo "   ANYDESK ID: $ANYDESK_ID"
    echo "=========================================================="
fi
