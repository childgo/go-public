```bash
#!/usr/bin/env bash

# Run directly from GitHub:
# bash <(curl -fsSL https://raw.githubusercontent.com/childgo/go-public/refs/heads/master/AlmaLinux9/CheckOpenPorts.sh)

# ============================================================
# AlmaLinux 9 - Incoming / Outgoing Port Checker
# ============================================================

# Do not use "set -e" here because failed port tests are expected.

# ------------------------------------------------------------
# Colors
# ------------------------------------------------------------

if [[ -t 1 ]]; then
    RED='\033[0;31m'
    GREEN='\033[0;32m'
    YELLOW='\033[1;33m'
    BLUE='\033[0;34m'
    CYAN='\033[0;36m'
    WHITE='\033[1;37m'
    MAGENTA='\033[0;35m'
    NC='\033[0m'
else
    RED=''
    GREEN=''
    YELLOW=''
    BLUE=''
    CYAN=''
    WHITE=''
    MAGENTA=''
    NC=''
fi

# ------------------------------------------------------------
# Ports
# ------------------------------------------------------------

IN_PORTS=(
    "25:SMTP"
    "53:DNS"
    "80:HTTP"
    "110:POP3"
    "143:IMAP"
    "443:HTTPS"
    "465:SMTP SSL/TLS"
    "587:SMTP Submission"
    "993:IMAP SSL/TLS"
    "995:POP3 SSL/TLS"
    "2095:Webmail"
    "2096:Webmail SSL"
)

OUT_PORTS=(
    "25:SMTP"
    "53:DNS"
    "80:HTTP"
    "110:POP3"
    "443:HTTPS"
    "587:SMTP Submission"
    "1215:SSH Custom"
    "2089:cPanel License"
    "3306:MySQL"
)

# ------------------------------------------------------------
# Basic functions
# ------------------------------------------------------------

line()
{
    echo -e "${CYAN}------------------------------------------------------------------------${NC}"
}

header()
{
    echo
    line
    printf "${WHITE}%-10s %-27s %-28s${NC}\n" "PORT" "SERVICE" "RESULT"
    line
}

pause_screen()
{
    echo
    if [[ -r /dev/tty ]]; then
        read -r -p "Press ENTER to continue..." </dev/tty
    fi
}

# ------------------------------------------------------------
# Root / sudo helper
# ------------------------------------------------------------

run_root()
{
    if [[ $EUID -eq 0 ]]; then
        "$@"
    elif command -v sudo >/dev/null 2>&1; then
        sudo "$@"
    else
        echo -e "${RED}[ERROR] Root privileges are required.${NC}"
        return 1
    fi
}

# ------------------------------------------------------------
# Check required commands
# ------------------------------------------------------------

install_dependencies()
{
    local need_install=0

    if ! command -v ss >/dev/null 2>&1; then
        echo -e "${YELLOW}[!] ss command is missing.${NC}"
        need_install=1
    fi

    if ! command -v ncat >/dev/null 2>&1 &&
       ! command -v nc >/dev/null 2>&1; then
        echo -e "${YELLOW}[!] ncat/nc is missing.${NC}"
        need_install=1
    fi

    if [[ $need_install -eq 1 ]]; then
        echo -e "${YELLOW}[!] Installing required packages...${NC}"
        echo

        run_root dnf install -y iproute nmap-ncat

        echo
    fi

    if command -v ncat >/dev/null 2>&1; then
        NC_BIN="$(command -v ncat)"
    elif command -v nc >/dev/null 2>&1; then
        NC_BIN="$(command -v nc)"
    else
        echo -e "${RED}[ERROR] ncat/nc could not be installed.${NC}"
        exit 1
    fi

    if ! command -v ss >/dev/null 2>&1; then
        echo -e "${RED}[ERROR] ss command is unavailable.${NC}"
        exit 1
    fi
}

# ------------------------------------------------------------
# Incoming TCP listener check
# ------------------------------------------------------------

tcp_listening()
{
    local port="$1"

    ss -H -lnt 2>/dev/null |
        awk '{print $4}' |
        grep -Eq "(^|[\]:])${port}$"
}

# ------------------------------------------------------------
# Incoming UDP listener check
# ------------------------------------------------------------

udp_listening()
{
    local port="$1"

    ss -H -lnu 2>/dev/null |
        awk '{print $5}' |
        grep -Eq "(^|[\]:])${port}$"

    # Different iproute2 versions can expose Local Address in a
    # different field, so try a more robust full-line check.
    if [[ $? -ne 0 ]]; then
        ss -H -lnu 2>/dev/null |
            grep -Eq "[[:space:]][^[:space:]]*[:.]${port}[[:space:]]"
    fi
}

# ------------------------------------------------------------
# Show process listening on port
# ------------------------------------------------------------

get_tcp_process()
{
    local port="$1"

    ss -H -lntp 2>/dev/null |
        grep -E "(^|[\]:])${port}[[:space:]]" |
        head -n1 |
        sed -n 's/.*users:(("\([^"]*\)".*/\1/p'
}

# ------------------------------------------------------------
# Incoming check
# ------------------------------------------------------------

check_incoming()
{
    clear

    echo -e "${CYAN}============================================================${NC}"
    echo -e "${WHITE}                  INCOMING PORT CHECK${NC}"
    echo -e "${CYAN}============================================================${NC}"
    echo
    echo "This checks whether a local service is LISTENING."
    echo
    echo -e "${YELLOW}Important:${NC} LISTENING does not prove that the port is"
    echo "reachable from another server on the Internet."

    header

    local entry port service process

    for entry in "${IN_PORTS[@]}"; do

        port="${entry%%:*}"
        service="${entry#*:}"

        if tcp_listening "$port"; then

            process="$(get_tcp_process "$port")"

            if [[ -n "$process" ]]; then
                printf "%-10s %-27s ${GREEN}%-20s${NC} ${MAGENTA}(%s)${NC}\n" \
                    "$port/TCP" "$service" "LISTENING" "$process"
            else
                printf "%-10s %-27s ${GREEN}%-28s${NC}\n" \
                    "$port/TCP" "$service" "LISTENING"
            fi

        else
            printf "%-10s %-27s ${RED}%-28s${NC}\n" \
                "$port/TCP" "$service" "NOT LISTENING"
        fi

        # DNS needs UDP as well.
        if [[ "$port" == "53" ]]; then

            if udp_listening 53; then
                printf "%-10s %-27s ${GREEN}%-28s${NC}\n" \
                    "53/UDP" "DNS" "LISTENING"
            else
                printf "%-10s %-27s ${RED}%-28s${NC}\n" \
                    "53/UDP" "DNS" "NOT LISTENING"
            fi
        fi

    done

    line

    echo
    echo -e "${WHITE}Firewall status:${NC}"

    if command -v firewall-cmd >/dev/null 2>&1; then

        if systemctl is-active --quiet firewalld 2>/dev/null; then
            echo -e "firewalld: ${GREEN}RUNNING${NC}"
            echo
            firewall-cmd --get-active-zones 2>/dev/null
            echo
            firewall-cmd --list-all 2>/dev/null
        else
            echo -e "firewalld: ${YELLOW}INSTALLED BUT NOT RUNNING${NC}"
        fi

    else
        echo -e "firewalld: ${YELLOW}NOT INSTALLED${NC}"
    fi

    echo
    echo -e "${YELLOW}NOTE:${NC}"
    echo "A green LISTENING result only means the service is bound locally."
    echo "An upstream firewall, hosting firewall, security group, NAT or ACL"
    echo "can still block connections coming from the Internet."
}

# ------------------------------------------------------------
# TCP outbound test
# ------------------------------------------------------------

test_tcp_out()
{
    local target="$1"
    local port="$2"

    "$NC_BIN" -z -w 3 "$target" "$port" >/dev/null 2>&1
}

# ------------------------------------------------------------
# Outgoing check
# ------------------------------------------------------------

check_outgoing()
{
    clear

    echo -e "${CYAN}============================================================${NC}"
    echo -e "${WHITE}                  OUTGOING PORT CHECK${NC}"
    echo -e "${CYAN}============================================================${NC}"
    echo

    echo -e "${YELLOW}IMPORTANT:${NC}"
    echo "For an accurate outbound test, enter an external server that"
    echo "you control and that is LISTENING on these ports."
    echo
    echo "A remote CLOSED port cannot distinguish:"
    echo
    echo "  - outbound firewall blocking"
    echo "  - remote firewall blocking"
    echo "  - remote service not listening"
    echo

    local TARGET

    if [[ -r /dev/tty ]]; then
        read -r -p "External test IP/hostname: " TARGET </dev/tty
    else
        read -r -p "External test IP/hostname: " TARGET
    fi

    if [[ -z "$TARGET" ]]; then
        echo
        echo -e "${RED}[ERROR] No external host was entered.${NC}"
        return
    fi

    echo
    echo -e "Destination: ${WHITE}${TARGET}${NC}"

    # Verify hostname/IP resolves before doing every test.
    if ! getent ahosts "$TARGET" >/dev/null 2>&1; then
        echo
        echo -e "${RED}[ERROR] Cannot resolve/reach hostname: ${TARGET}${NC}"
        echo "Check the hostname or DNS configuration."
        return
    fi

    header

    local entry port service

    for entry in "${OUT_PORTS[@]}"; do

        port="${entry%%:*}"
        service="${entry#*:}"

        if test_tcp_out "$TARGET" "$port"; then

            printf "%-10s %-27s ${GREEN}%-28s${NC}\n" \
                "$port/TCP" "$service" "CONNECTED"

        else

            printf "%-10s %-27s ${RED}%-28s${NC}\n" \
                "$port/TCP" "$service" "NO CONNECTION"

        fi
    done

    line

    echo
    echo -e "${WHITE}Basic Internet sanity checks:${NC}"
    echo

    printf "%-30s " "HTTPS google.com:443"

    if test_tcp_out "google.com" 443; then
        echo -e "${GREEN}CONNECTED${NC}"
    else
        echo -e "${RED}FAILED${NC}"
    fi

    printf "%-30s " "HTTP example.com:80"

    if test_tcp_out "example.com" 80; then
        echo -e "${GREEN}CONNECTED${NC}"
    else
        echo -e "${RED}FAILED${NC}"
    fi

    printf "%-30s " "DNS TCP 1.1.1.1:53"

    if test_tcp_out "1.1.1.1" 53; then
        echo -e "${GREEN}CONNECTED${NC}"
    else
        echo -e "${RED}FAILED${NC}"
    fi

    echo
    echo -e "${YELLOW}NOTE:${NC}"
    echo "NO CONNECTION does NOT automatically mean the local firewall"
    echo "blocked the port. The destination may simply have that port closed."
}

# ------------------------------------------------------------
# Local firewall rules
# ------------------------------------------------------------

show_firewall()
{
    clear

    echo -e "${CYAN}============================================================${NC}"
    echo -e "${WHITE}                    FIREWALL RULES${NC}"
    echo -e "${CYAN}============================================================${NC}"
    echo

    if command -v firewall-cmd >/dev/null 2>&1; then

        echo -e "${WHITE}firewalld:${NC}"

        if systemctl is-active --quiet firewalld 2>/dev/null; then
            echo -e "${GREEN}RUNNING${NC}"
            echo
            firewall-cmd --get-active-zones
            echo
            firewall-cmd --list-all
        else
            echo -e "${YELLOW}NOT RUNNING${NC}"
        fi

    else
        echo -e "${YELLOW}firewalld is not installed.${NC}"
    fi

    echo
    line
    echo
    echo -e "${WHITE}nftables relevant rules:${NC}"
    echo

    if command -v nft >/dev/null 2>&1; then
        nft list ruleset 2>/dev/null |
            grep -Ei 'drop|reject|accept|dport|sport' || true
    else
        echo "nft command not installed."
    fi
}

# ------------------------------------------------------------
# Main menu
# ------------------------------------------------------------

main_menu()
{
    while true; do

        clear

        echo -e "${CYAN}============================================================${NC}"
        echo -e "${WHITE}       AlmaLinux 9 Network Port Connectivity Checker${NC}"
        echo -e "${CYAN}============================================================${NC}"
        echo
        echo -e " ${GREEN}1${NC}) Check INCOMING ports"
        echo -e " ${GREEN}2${NC}) Check OUTGOING ports"
        echo -e " ${GREEN}3${NC}) Check BOTH"
        echo -e " ${GREEN}4${NC}) Show firewall rules"
        echo -e " ${RED}0${NC}) Exit"
        echo

        local OPTION

        if [[ -r /dev/tty ]]; then
            read -r -p "Select [0-4]: " OPTION </dev/tty
        else
            read -r -p "Select [0-4]: " OPTION
        fi

        case "$OPTION" in

            1)
                check_incoming
                pause_screen
                ;;

            2)
                check_outgoing
                pause_screen
                ;;

            3)
                check_incoming
                echo
                pause_screen
                check_outgoing
                pause_screen
                ;;

            4)
                show_firewall
                pause_screen
                ;;

            0)
                echo
                echo -e "${GREEN}Goodbye.${NC}"
                exit 0
                ;;

            *)
                echo
                echo -e "${RED}[ERROR] Invalid selection.${NC}"
                sleep 1
                ;;
        esac
    done
}

# ------------------------------------------------------------
# Start
# ------------------------------------------------------------

install_dependencies
main_menu
```
