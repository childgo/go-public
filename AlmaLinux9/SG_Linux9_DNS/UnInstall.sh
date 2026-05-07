#!/bin/bash
# ALSCO Secure Gateway DNS Manager for AlmaLinux 9
#bash <(curl -s https://raw.githubusercontent.com/childgo/go-public/refs/heads/master/AlmaLinux9/SG_Linux9_DNS/UnInstall.sh)

set -u

SERVICE_NAME="SecureGateway_DNS"
SCRIPT_PATH="/opt/SecureGateway_DNS.py"
SERVICE_PATH="/etc/systemd/system/${SERVICE_NAME}.service"
RESOLV_CONF="/etc/resolv.conf"
UPSTREAM_API="http://66.111.53.72/SecureGateway-dns-query?name=gmail.com&type=A"

pause() {
    echo
    read -rp "Press Enter to continue..."
}

verify_all() {
    clear
    echo "========================================"
    echo " ALSCO Secure Gateway DNS Verification"
    echo "========================================"
    echo

    echo "1) Checking /etc/resolv.conf"
    echo "----------------------------------------"
    cat "$RESOLV_CONF" 2>/dev/null || echo "Cannot read $RESOLV_CONF"
    echo

    echo "2) Checking if $SERVICE_NAME service exists"
    echo "----------------------------------------"
    systemctl status "$SERVICE_NAME" --no-pager || true
    echo

    echo "3) Checking port 53 owner"
    echo "----------------------------------------"
    ss -tulnp | grep ':53' || echo "No process listening on port 53"
    echo

    echo "4) Checking Python script"
    echo "----------------------------------------"
    if [ -f "$SCRIPT_PATH" ]; then
        echo "Found: $SCRIPT_PATH"
        python3 -m py_compile "$SCRIPT_PATH" && echo "Python syntax: OK" || echo "Python syntax: FAILED"
    else
        echo "Missing: $SCRIPT_PATH"
    fi
    echo

    echo "5) Testing upstream API: 66.111.53.72"
    echo "----------------------------------------"
    curl -sS --max-time 5 "$UPSTREAM_API" || echo "Upstream API failed"
    echo
    echo

    echo "6) Testing local DNS with +noedns"
    echo "----------------------------------------"
    dig +noedns @127.0.0.1 gmail.com || true
    echo

    echo "7) Testing normal local DNS"
    echo "----------------------------------------"
    dig @127.0.0.1 gmail.com || true
    echo

    echo "8) Testing system DNS"
    echo "----------------------------------------"
    dig gmail.com || true
    echo

    echo "9) Recent service logs"
    echo "----------------------------------------"
    journalctl -u "$SERVICE_NAME" -n 40 --no-pager || true

    pause
}

uninstall_all() {
    clear
    echo "========================================"
    echo " Uninstall ALSCO Secure Gateway DNS"
    echo " Restore AlmaLinux 9 default DNS behavior"
    echo "========================================"
    echo

    read -rp "Are you sure? This will remove SecureGateway_DNS and unlock resolv.conf. Type YES: " confirm
    if [ "$confirm" != "YES" ]; then
        echo "Cancelled."
        pause
        return
    fi

    echo
    echo "1) Unlocking /etc/resolv.conf..."
    chattr -i "$RESOLV_CONF" 2>/dev/null || true

    echo "2) Stopping SecureGateway_DNS..."
    systemctl stop "$SERVICE_NAME" 2>/dev/null || true
    systemctl disable "$SERVICE_NAME" 2>/dev/null || true

    echo "3) Killing leftover SecureGateway processes..."
    pkill -f "$SCRIPT_PATH" 2>/dev/null || true
    pkill -f "SecureGateway_DNS.py" 2>/dev/null || true

    echo "4) Removing systemd service..."
    rm -f "$SERVICE_PATH"
    systemctl daemon-reload
    systemctl reset-failed "$SERVICE_NAME" 2>/dev/null || true

    echo "5) Removing Python script..."
    rm -f "$SCRIPT_PATH"

    echo "6) Restoring /etc/resolv.conf for NetworkManager..."
    rm -f "$RESOLV_CONF"
    touch "$RESOLV_CONF"

    echo "7) Restarting NetworkManager..."
    systemctl restart NetworkManager

    echo "8) Re-enabling PowerDNS if it was masked..."
    systemctl unmask pdns 2>/dev/null || true
    systemctl enable pdns 2>/dev/null || true
    systemctl start pdns 2>/dev/null || true

    echo
    echo "9) Final DNS status:"
    echo "----------------------------------------"
    cat "$RESOLV_CONF" 2>/dev/null || true
    echo
    ss -tulnp | grep ':53' || echo "No process listening on port 53"
    echo
    dig gmail.com || true

    echo
    echo "Uninstall completed."
    pause
}

restart_sg() {
    clear
    echo "Restarting $SERVICE_NAME..."
    systemctl restart "$SERVICE_NAME"
    systemctl status "$SERVICE_NAME" --no-pager || true
    pause
}

show_logs() {
    clear
    journalctl -u "$SERVICE_NAME" -n 100 --no-pager || true
    pause
}

while true; do
    clear
    echo "========================================"
    echo " ALSCO Secure Gateway DNS Manager"
    echo " AlmaLinux 9"
    echo "========================================"
    echo
    echo "1) Verify everything is running"
    echo "2) Restart SecureGateway_DNS"
    echo "3) Show SecureGateway_DNS logs"
    echo "4) Uninstall everything and restore default DNS"
    echo "5) Exit"
    echo
    read -rp "Choose option [1-5]: " choice

    case "$choice" in
        1) verify_all ;;
        2) restart_sg ;;
        3) show_logs ;;
        4) uninstall_all ;;
        5) exit 0 ;;
        *) echo "Invalid option"; sleep 1 ;;
    esac
done
