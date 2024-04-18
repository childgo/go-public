#!/bin/bash

# Configuration
INTERFACE="wan1"  # Interface to monitor
INTERVAL=2        # Update interval in seconds
SCALE=10          # Scale for the graphical representation (1 unit = 10 Mbps)

# Function to draw a text-based bar graph
draw_bar() {
    local value=$1
    local max_width=50  # max width of the bar graph
    local scaled_value=$(echo "$value / $SCALE" | bc)
    local bar_width=$((scaled_value > max_width ? max_width : scaled_value))
    local bar=''
    for ((i=0; i<bar_width; i++)); do
        bar+='|'
    done
    printf '%-50s' "$bar"
}

# Main monitoring loop
echo "Monitoring $INTERFACE every $INTERVAL seconds. Press Ctrl+C to stop."
while true; do
    # Fetch initial stats
    INITIAL_STATS=$(ssh admin@fortigate_ip "diagnose netlink interface name $INTERFACE")
    RX_INITIAL=$(echo "$INITIAL_STATS" | grep RX | grep bytes | awk '{print $2}')
    TX_INITIAL=$(echo "$INITIAL_STATS" | grep TX | grep bytes | awk '{print $2}')

    sleep $INTERVAL

    # Fetch final stats
    FINAL_STATS=$(ssh admin@fortigate_ip "diagnose netlink interface name $INTERFACE")
    RX_FINAL=$(echo "$FINAL_STATS" | grep RX | grep bytes | awk '{print $2}')
    TX_FINAL=$(echo "$FINAL_STATS" | grep TX | grep bytes | awk '{print $2}')

    # Calculate bandwidth
    RX_DIFF=$((RX_FINAL - RX_INITIAL))
    TX_DIFF=$((TX_FINAL - TX_INITIAL))
    RX_Mbps=$(echo "scale=2; $RX_DIFF * 8 / 1024 / 1024 / $INTERVAL" | bc)
    TX_Mbps=$(echo "scale=2; $TX_DIFF * 8 / 1024 / 1024 / $INTERVAL" | bc)

    # Output results with bar graph
    echo -n "$(date +"%Y-%m-%d %H:%M:%S"): Upload = $TX_Mbps Mbps "
    draw_bar $TX_Mbps
    echo -n " Download = $RX_Mbps Mbps "
    draw_bar $RX_Mbps
    echo ""
done
