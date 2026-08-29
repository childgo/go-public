```bash
#!/bin/bash

# ============================================================
# AlmaLinux 9 - Incoming / Outgoing Port Checker
# ============================================================

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m'

# Port definitions
declare -A OUT_PORTS=(
    [110]="POP3"
    [1215]="SSH Custom"
    [2089]="cPanel License"
    [25]="SMTP"
    [3306]="MySQL"
    [443]="HTTPS"
    [53]="DNS"
    [587]="SMTP Submission"
    [80]="HTTP"
)

declare -A IN_PORTS=(
    [110]="POP3"
    [143]="IMAP"
    [2095]="Webmail"
    [2096]="Webmail SSL"
    [25]="SMTP"
    [443]="HTTPS"
    [465]="SMTP SSL/TLS"
    [53]="DNS"
    [587]="SMTP Submission"
    [80]="HTTP"
    [993]="IMAP SSL/TLS"
    [995]="POP3 SSL/TLS"
)

clear

echo -e "${CYAN}============================================================${NC}"
echo -e "${WHITE}       AlmaLinux 9 - Network Port Connectivity Checker${NC}"
echo -e "${CYAN}============================================================${NC}"
echo

# ------------------------------------------------------------
# Check nc / nmap-ncat
# ------------------------------------------------------------

if ! command -v nc >/dev/null 2>&1; then
    echo -e "${YELLOW}[!] ncat/nc is not installed.${NC}"
    echo -e "${YELLOW}[!] Installing nmap-ncat...${NC}"
    echo

    sudo dnf install -y nmap-ncat

    if ! command -v nc >/dev/null 2>&1; then
        echo -e "${RED}[ERROR] Could not install nmap-ncat.${NC}"
        exit 1
    fi

    echo
    echo -e "${GREEN}[OK] nmap-ncat installed successfully.${NC}"
    echo
fi

# ------------------------------------------------------------
# Header function
# ------------------------------------------------------------

print_header() {
    echo
    echo -e "${CYAN}-----------------------------------------------------------------${NC}"
    printf "${WHITE}%-8s %-25s %-25s${NC}\n" "PORT" "SERVICE" "RESULT"
    echo -e "${CYAN}-----------------------------------------------------------------${NC}"
}

# ------------------------------------------------------------
# Incoming test
# ------------------------------------------------------------

check_incoming() {

    echo
    echo -e "${BLUE}Incoming Port Test${NC}"
    echo -e "Checking whether services are listening on this AlmaLinux server."
    echo

    print_header

    for port in $(printf "%s\n" "${!IN_PORTS[@]}" | sort -n); do

        service="${IN_PORTS[$port]}"

        # TCP check
        if ss -lntp 2>/dev/null | awk '{print $4}' | grep -Eq "(^|:)$port$"; then
            printf "%-8s %-25s ${GREEN}%-25s${NC}\n" \
                "$port" "$service" "TCP LISTENING"
        else
            printf "%-8s %-25s ${RED}%-25s${NC}\n" \
                "$port" "$service" "TCP NOT LISTENING"
        fi

        # Port 53 also needs UDP checking
        if [ "$port" = "53" ]; then

            if ss -lnup 2>/dev/null | awk '{print $5}' | grep -Eq "(^|:)53$"; then
                printf "%-8s %-25s ${GREEN}%-25s${NC}\n" \
                    "53/UDP" "DNS" "UDP LISTENING"
            else
                printf "%-8s %-25s ${RED}%-25s${NC}\n" \
                    "53/UDP" "DNS" "UDP NOT LISTENING"
            fi

        fi
    done

    echo -e "${CYAN}-----------------------------------------------------------------${NC}"

    echo
    echo -e "${YELLOW}Firewall configuration:${NC}"
    echo

    if command -v firewall-cmd >/dev/null 2>&1; then
        firewall-cmd --get-active-zones 2>/dev/null
        echo
        firewall-cmd --list-all 2>/dev/null
    else
        echo -e "${YELLOW}firewalld is not installed/running.${NC}"
    fi

    echo
    echo -e "${YELLOW}NOTE:${NC}"
    echo "LISTENING means an application is bound to the port."
    echo "It does NOT by itself prove that the port is reachable from the Internet."
    echo "Cloud/provider firewalls, routers, NAT and upstream ACLs may still block it."
}

# ------------------------------------------------------------
# Outgoing test
# ------------------------------------------------------------

check_outgoing() {

    echo
    echo -e "${BLUE}Outgoing Port Test${NC}"
    echo
    echo "Enter an external server IP or hostname."
    echo
    echo -e "${YELLOW}IMPORTANT:${NC} The destination server must actually listen"
    echo "on the ports being tested, otherwise a permitted outbound port can"
    echo "still appear FAILED."
    echo

    read -rp "External IP/Hostname: " TARGET

    if [ -z "$TARGET" ]; then
        echo -e "${RED}[ERROR] No destination entered.${NC}"
        exit 1
    fi

    echo
    echo -e "Testing outbound TCP connectivity to: ${WHITE}$TARGET${NC}"

    print_header

    for port in $(printf "%s\n" "${!OUT_PORTS[@]}" | sort -n); do

        service="${OUT_PORTS[$port]}"

        if nc -z -w3 "$TARGET" "$port" >/dev/null 2>&1; then

            printf "%-8s %-25s ${GREEN}%-25s${NC}\n" \
                "$port" "$service" "CONNECTED"

        else

            printf "%-8s %-25s ${RED}%-25s${NC}\n" \
                "$port" "$service" "FAILED / BLOCKED"

        fi

        # DNS UDP test
        if [ "$port" = "53" ]; then

            if nc -z -u -w3 "$TARGET" 53 >/dev/null 2>&1; then

                printf "%-8s %-25s ${GREEN}%-25s${NC}\n" \
                    "53/UDP" "DNS" "UDP REACHABLE"

            else

                printf "%-8s %-25s ${YELLOW}%-25s${NC}\n" \
                    "53/UDP" "DNS" "UDP NO RESPONSE"

            fi

        fi

    done

    echo -e "${CYAN}-----------------------------------------------------------------${NC}"

    echo
    echo -e "${YELLOW}NOTE:${NC}"
    echo "FAILED/BLOCKED does not automatically mean your firewall blocked it."
    echo "The remote server may simply not have that port open."
}

# ------------------------------------------------------------
# Menu
# ------------------------------------------------------------

echo -e "${WHITE}What do you want to test?${NC}"
echo
echo -e "  ${GREEN}1)${NC} Incoming ports"
echo -e "  ${GREEN}2)${NC} Outgoing ports"
echo -e "  ${GREEN}3)${NC} Both"
echo -e "  ${RED}0)${NC} Exit"
echo

read -rp "Select [0-3]: " OPTION

case "$OPTION" in

    1)
        check_incoming
        ;;

    2)
        check_outgoing
        ;;

    3)
        check_incoming
        echo
        check_outgoing
        ;;

    0)
        echo "Exit."
        exit 0
        ;;

    *)
        echo -e "${RED}Invalid selection.${NC}"
        exit 1
        ;;

esac

echo
echo -e "${CYAN}============================================================${NC}"
echo -e "${GREEN}Test completed.${NC}"
echo -e "${CYAN}============================================================${NC}"
```
