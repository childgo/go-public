#!/bin/bash


#bash <(curl -s https://raw.githubusercontent.com/childgo/go-public/refs/heads/master/AlmaLinux9/Third-Party/Install.sh)



# ===== Colors =====
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m' # No Color

cd /opt || { echo -e "${RED}ERROR: cannot cd to /opt${NC}"; exit 1; }
GITHUB_BASE="https://raw.githubusercontent.com/childgo/go-public/master/AlmaLinux9/Third-Party"
sleep 2

check_installed() {
    PKG_NAME="$1"
    case "$PKG_NAME" in
        csf)
            if [ -f /etc/csf/csf.conf ] || [ -d /usr/local/csf ] || [ -f /usr/sbin/csf ]; then
                return 0
            else
                return 1
            fi
            ;;
        cmm)
            # CHANGE THIS if cmm installs somewhere else
            if [ -d /usr/local/cmm ] || [ -f /usr/local/bin/cmm ] || systemctl list-unit-files 2>/dev/null | grep -q '^cmm\.service'; then
                return 0
            else
                return 1
            fi
            ;;
        cmq)
            # CHANGE THIS if cmq installs somewhere else
            if [ -d /usr/local/cmq ] || [ -f /usr/local/bin/cmq ] || systemctl list-unit-files 2>/dev/null | grep -q '^cmq\.service'; then
                return 0
            else
                return 1
            fi
            ;;
        cse)
            # CHANGE THIS if cse installs somewhere else
            if [ -d /usr/local/cse ] || [ -f /usr/local/bin/cse ] || systemctl list-unit-files 2>/dev/null | grep -q '^cse\.service'; then
                return 0
            else
                return 1
            fi
            ;;
        *)
            return 1
            ;;
    esac
}

# ===== Ask user Yes/No before installing a package =====
confirm_install() {
    PKG_NAME="$1"
    while true; do
        read -rp "$(echo -e "${YELLOW}Install ${BOLD}${PKG_NAME}${NC}${YELLOW}? (Yes/No): ${NC}")" ANSWER
        case "$ANSWER" in
            [Yy][Ee][Ss]|[Yy])
                return 0
                ;;
            [Nn][Oo]|[Nn])
                return 1
                ;;
            *)
                echo -e "${RED}Please answer Yes or No.${NC}"
                ;;
        esac
    done
}

install_pkg() {
    PKG_NAME="$1"
    PKG_FILE="${PKG_NAME}.tgz"
    PKG_URL="${GITHUB_BASE}/${PKG_FILE}"

    echo -e "${CYAN}==============================${NC}"
    echo -e "${CYAN}Checking ${BOLD}${PKG_NAME}${NC}${CYAN} ...${NC}"
    echo -e "${CYAN}==============================${NC}"
    sleep 2

    check_installed "$PKG_NAME"
    if [ $? -eq 0 ]; then
        echo -e "${YELLOW}NOTICE: ${PKG_NAME} appears to be already installed. Skipping.${NC}"
        echo
        return
    fi

    # Ask before proceeding
    if ! confirm_install "$PKG_NAME"; then
        echo -e "${YELLOW}Skipping ${PKG_NAME} (user declined).${NC}"
        echo
        return
    fi

    echo -e "${GREEN}Downloading ${PKG_FILE} ...${NC}"
    wget -O "/opt/${PKG_FILE}" "$PKG_URL"
    if [ $? -ne 0 ]; then
        echo -e "${RED}ERROR: failed to download ${PKG_FILE}${NC}"
        echo
        return
    fi
    sleep 3

    echo -e "${GREEN}Extracting ${PKG_FILE} ...${NC}"
    tar -xzf "/opt/${PKG_FILE}" -C /opt
    if [ $? -ne 0 ]; then
        echo -e "${RED}ERROR: failed to extract ${PKG_FILE}${NC}"
        rm -rf "/opt/${PKG_FILE}"
        echo
        return
    fi
    sleep 3

    if [ ! -d "/opt/${PKG_NAME}" ]; then
        echo -e "${RED}ERROR: /opt/${PKG_NAME} not found after extraction${NC}"
        rm -rf "/opt/${PKG_FILE}"
        echo
        return
    fi

    cd "/opt/${PKG_NAME}" || {
        echo -e "${RED}ERROR: cannot cd to /opt/${PKG_NAME}${NC}"
        echo
        return
    }
    sleep 3

    if [ ! -f install.sh ]; then
        echo -e "${RED}ERROR: install.sh not found in /opt/${PKG_NAME}${NC}"
        cd /opt
        rm -rf "/opt/${PKG_NAME}"
        rm -rf "/opt/${PKG_FILE}"
        echo
        return
    fi

    echo -e "${GREEN}Running install.sh for ${PKG_NAME} ...${NC}"
    sh install.sh
    if [ $? -ne 0 ]; then
        echo -e "${RED}ERROR: install.sh failed for ${PKG_NAME}${NC}"
        cd /opt
        echo
        return
    fi
    sleep 3

    cd /opt || return
    rm -rf "/opt/${PKG_NAME}"
    sleep 3
    rm -rf "/opt/${PKG_FILE}"
    sleep 3
    cd ~
    sleep 3

    if [ "$PKG_NAME" = "csf" ]; then
        systemctl enable csf
        if [ $? -ne 0 ]; then
            echo -e "${RED}ERROR: failed to enable csf${NC}"
        fi
        sleep 3
        systemctl enable lfd
        if [ $? -ne 0 ]; then
            echo -e "${RED}ERROR: failed to enable lfd${NC}"
        fi
        sleep 3
    fi

    echo -e "${GREEN}${BOLD}${PKG_NAME} install finished.${NC}"
    echo
}

install_pkg "cmm"
install_pkg "cmq"
install_pkg "cse"
install_pkg "csf"

echo -e "${GREEN}${BOLD}All done.${NC}"
