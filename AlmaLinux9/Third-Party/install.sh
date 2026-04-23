#!/bin/bash


#bash <(curl -s https://raw.githubusercontent.com/childgo/go-public/refs/heads/master/AlmaLinux9/Third-Party/install.sh)



cd /opt || { echo "ERROR: cannot cd to /opt"; exit 1; }

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

install_pkg() {
    PKG_NAME="$1"
    PKG_FILE="${PKG_NAME}.tgz"
    PKG_URL="${GITHUB_BASE}/${PKG_FILE}"

    echo "=============================="
    echo "Checking ${PKG_NAME} ..."
    echo "=============================="
    sleep 2

    check_installed "$PKG_NAME"
    if [ $? -eq 0 ]; then
        echo "ERROR: ${PKG_NAME} appears to be already installed. Skipping."
        echo
        return
    fi

    echo "Downloading ${PKG_FILE} ..."
    wget -O "/opt/${PKG_FILE}" "$PKG_URL"
    if [ $? -ne 0 ]; then
        echo "ERROR: failed to download ${PKG_FILE}"
        echo
        return
    fi
    sleep 3

    echo "Extracting ${PKG_FILE} ..."
    tar -xzf "/opt/${PKG_FILE}" -C /opt
    if [ $? -ne 0 ]; then
        echo "ERROR: failed to extract ${PKG_FILE}"
        rm -rf "/opt/${PKG_FILE}"
        echo
        return
    fi
    sleep 3

    if [ ! -d "/opt/${PKG_NAME}" ]; then
        echo "ERROR: /opt/${PKG_NAME} not found after extraction"
        rm -rf "/opt/${PKG_FILE}"
        echo
        return
    fi

    cd "/opt/${PKG_NAME}" || {
        echo "ERROR: cannot cd to /opt/${PKG_NAME}"
        echo
        return
    }
    sleep 3

    if [ ! -f install.sh ]; then
        echo "ERROR: install.sh not found in /opt/${PKG_NAME}"
        cd /opt
        rm -rf "/opt/${PKG_NAME}"
        rm -rf "/opt/${PKG_FILE}"
        echo
        return
    fi

    echo "Running install.sh for ${PKG_NAME} ..."
    sh install.sh
    if [ $? -ne 0 ]; then
        echo "ERROR: install.sh failed for ${PKG_NAME}"
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
            echo "ERROR: failed to enable csf"
        fi
        sleep 3

        systemctl enable lfd
        if [ $? -ne 0 ]; then
            echo "ERROR: failed to enable lfd"
        fi
        sleep 3
    fi

    echo "${PKG_NAME} install finished."
    echo
}

install_pkg "cmm"
install_pkg "cmq"
install_pkg "cse"
install_pkg "csf"

echo "All done."
