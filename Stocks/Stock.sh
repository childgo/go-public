#!/bin/bash
#bash <(curl -s https://raw.githubusercontent.com/childgo/go-public/refs/heads/master/Stocks/Stock.sh)

# ─────────────────────────────────────────────
#        TRADING BOT MANAGER
# ─────────────────────────────────────────────

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# ── Etrade bots ──────────────────────────────
declare -A ETRADE_BOTS=(
    [1]="Etrade_NVDA|Etrade|NVDA|NVDA"
    [2]="Etrade_SPY|Etrade|SPY|SPY"
    [3]="Etrade_PLTR|Etrade|PLTR|PLTR"
    [4]="Etrade_QQQ|Etrade|QQQ|QQQ"
    [5]="Etrade_MSFT|Etrade|MSFT|MSFT"
)

# ── Alpaca bots ──────────────────────────────
declare -A ALPACA_BOTS=(
    [1]="Alpaca_SPY|Alpaca|SPY|SPY"
    [2]="Alpaca_QQQ|Alpaca|QQQ|QQQ"
)

SCRIPT="/home/alscolive/public_html/python/trigger_allPY/Bot.py"

# ─────────────────────────────────────────────
print_header() {
    clear
    echo -e "${CYAN}${BOLD}"
    echo "  ╔══════════════════════════════════════╗"
    echo "  ║        TRADING BOT MANAGER           ║"
    echo "  ╚══════════════════════════════════════╝"
    echo -e "${NC}"
}

is_running() {
    local name=$1
    screen -list | grep -q "$name"
}

status_icon() {
    if is_running "$1"; then
        echo -e "${GREEN}[RUNNING]${NC}"
    else
        echo -e "${RED}[STOPPED]${NC}"
    fi
}

# ─────────────────────────────────────────────
start_bot() {
    local entry=$1
    local name=$(echo $entry | cut -d'|' -f1)
    local broker=$(echo $entry | cut -d'|' -f2)
    local monitor=$(echo $entry | cut -d'|' -f3)
    local buy=$(echo $entry | cut -d'|' -f4)

    if is_running "$name"; then
        echo -e "${YELLOW}⚠  $name is already running!${NC}"
    else
        screen -dmS "$name" bash -c "clear; python3 $SCRIPT Broker[$broker] Monitor[$monitor] Buy[$buy]"
        sleep 0.5
        if is_running "$name"; then
            echo -e "${GREEN}✔  $name started successfully!${NC}"
        else
            echo -e "${RED}✘  Failed to start $name.${NC}"
        fi
    fi
}

kill_bot() {
    local name=$1
    if is_running "$name"; then
        echo -e "  ${YELLOW}▶ Running:${NC} ${CYAN}screen -S $name -X quit${NC}"
        screen -S "$name" -X quit
        sleep 0.3
        echo -e "${RED}✘  $name killed.${NC}"
    else
        echo -e "${YELLOW}⚠  $name is not running.${NC}"
    fi
}

# ─────────────────────────────────────────────
menu_etrade() {
    while true; do
        print_header
        echo -e "${BOLD}  📈  ETRADE BOTS${NC}"
        echo "  ──────────────────────────────────────"
        for key in $(echo "${!ETRADE_BOTS[@]}" | tr ' ' '\n' | sort -n); do
            local entry="${ETRADE_BOTS[$key]}"
            local name=$(echo $entry | cut -d'|' -f1)
            local monitor=$(echo $entry | cut -d'|' -f3)
            echo -e "  ${BOLD}[$key]${NC} $name  $(status_icon $name)"
        done
        echo ""
        echo -e "  ${BOLD}[A]${NC} Start ALL Etrade bots"
        echo -e "  ${BOLD}[K]${NC} Kill a specific bot"
        echo -e "  ${BOLD}[0]${NC} Back to main menu"
        echo ""
        read -p "  Choose: " choice

        case $choice in
            [1-5])
                entry="${ETRADE_BOTS[$choice]}"
                if [ -n "$entry" ]; then
                    start_bot "$entry"
                    read -p "  Press Enter to continue..."
                fi
                ;;
            A|a)
                for key in $(echo "${!ETRADE_BOTS[@]}" | tr ' ' '\n' | sort -n); do
                    start_bot "${ETRADE_BOTS[$key]}"
                done
                read -p "  Press Enter to continue..."
                ;;
            K|k)
                menu_kill_etrade
                ;;
            0)
                break
                ;;
            *)
                echo -e "${RED}  Invalid option.${NC}"
                sleep 1
                ;;
        esac
    done
}

# ─────────────────────────────────────────────
menu_alpaca() {
    while true; do
        print_header
        echo -e "${BOLD}  🦙  ALPACA BOTS${NC}"
        echo "  ──────────────────────────────────────"
        for key in $(echo "${!ALPACA_BOTS[@]}" | tr ' ' '\n' | sort -n); do
            local entry="${ALPACA_BOTS[$key]}"
            local name=$(echo $entry | cut -d'|' -f1)
            echo -e "  ${BOLD}[$key]${NC} $name  $(status_icon $name)"
        done
        echo ""
        echo -e "  ${BOLD}[A]${NC} Start ALL Alpaca bots"
        echo -e "  ${BOLD}[K]${NC} Kill a specific bot"
        echo -e "  ${BOLD}[0]${NC} Back to main menu"
        echo ""
        read -p "  Choose: " choice

        case $choice in
            [1-2])
                entry="${ALPACA_BOTS[$choice]}"
                if [ -n "$entry" ]; then
                    start_bot "$entry"
                    read -p "  Press Enter to continue..."
                fi
                ;;
            A|a)
                for key in $(echo "${!ALPACA_BOTS[@]}" | tr ' ' '\n' | sort -n); do
                    start_bot "${ALPACA_BOTS[$key]}"
                done
                read -p "  Press Enter to continue..."
                ;;
            K|k)
                menu_kill_alpaca
                ;;
            0)
                break
                ;;
            *)
                echo -e "${RED}  Invalid option.${NC}"
                sleep 1
                ;;
        esac
    done
}

# ─────────────────────────────────────────────
menu_kill_etrade() {
    print_header
    echo -e "${BOLD}  🔴  KILL ETRADE BOT${NC}"
    echo "  ──────────────────────────────────────"
    for key in $(echo "${!ETRADE_BOTS[@]}" | tr ' ' '\n' | sort -n); do
        local entry="${ETRADE_BOTS[$key]}"
        local name=$(echo $entry | cut -d'|' -f1)
        echo -e "  ${BOLD}[$key]${NC} $name  $(status_icon $name)"
    done
    echo -e "  ${BOLD}[A]${NC} Kill ALL Etrade bots"
    echo -e "  ${BOLD}[0]${NC} Back"
    echo ""
    read -p "  Choose: " choice

    case $choice in
        [1-5])
            entry="${ETRADE_BOTS[$choice]}"
            if [ -n "$entry" ]; then
                name=$(echo $entry | cut -d'|' -f1)
                kill_bot "$name"
                read -p "  Press Enter to continue..."
            fi
            ;;
        A|a)
            for key in $(echo "${!ETRADE_BOTS[@]}" | tr ' ' '\n' | sort -n); do
                name=$(echo "${ETRADE_BOTS[$key]}" | cut -d'|' -f1)
                kill_bot "$name"
            done
            read -p "  Press Enter to continue..."
            ;;
        0) return ;;
    esac
}

menu_kill_alpaca() {
    print_header
    echo -e "${BOLD}  🔴  KILL ALPACA BOT${NC}"
    echo "  ──────────────────────────────────────"
    for key in $(echo "${!ALPACA_BOTS[@]}" | tr ' ' '\n' | sort -n); do
        local entry="${ALPACA_BOTS[$key]}"
        local name=$(echo $entry | cut -d'|' -f1)
        echo -e "  ${BOLD}[$key]${NC} $name  $(status_icon $name)"
    done
    echo -e "  ${BOLD}[A]${NC} Kill ALL Alpaca bots"
    echo -e "  ${BOLD}[0]${NC} Back"
    echo ""
    read -p "  Choose: " choice

    case $choice in
        [1-2])
            entry="${ALPACA_BOTS[$choice]}"
            if [ -n "$entry" ]; then
                name=$(echo $entry | cut -d'|' -f1)
                kill_bot "$name"
                read -p "  Press Enter to continue..."
            fi
            ;;
        A|a)
            for key in $(echo "${!ALPACA_BOTS[@]}" | tr ' ' '\n' | sort -n); do
                name=$(echo "${ALPACA_BOTS[$key]}" | cut -d'|' -f1)
                kill_bot "$name"
            done
            read -p "  Press Enter to continue..."
            ;;
        0) return ;;
    esac
}

# ─────────────────────────────────────────────
menu_kill_all() {
    print_header
    echo -e "${BOLD}  🔴  KILL BOTS${NC}"
    echo "  ──────────────────────────────────────"

    ALL_NAMES=()
    idx=1
    for key in $(echo "${!ETRADE_BOTS[@]}" | tr ' ' '\n' | sort -n); do
        name=$(echo "${ETRADE_BOTS[$key]}" | cut -d'|' -f1)
        ALL_NAMES+=("$name")
        echo -e "  ${BOLD}[$idx]${NC} $name  $(status_icon $name)"
        ((idx++))
    done
    for key in $(echo "${!ALPACA_BOTS[@]}" | tr ' ' '\n' | sort -n); do
        name=$(echo "${ALPACA_BOTS[$key]}" | cut -d'|' -f1)
        ALL_NAMES+=("$name")
        echo -e "  ${BOLD}[$idx]${NC} $name  $(status_icon $name)"
        ((idx++))
    done

    echo ""
    echo -e "  ${BOLD}[A]${NC} Kill ALL bots"
    echo -e "  ${BOLD}[0]${NC} Back to main menu"
    echo ""
    read -p "  Choose: " choice

    if [[ "$choice" == "A" || "$choice" == "a" ]]; then
        for name in "${ALL_NAMES[@]}"; do
            kill_bot "$name"
        done
        read -p "  Press Enter to continue..."
    elif [[ "$choice" =~ ^[0-9]+$ ]] && [ "$choice" -ge 1 ] && [ "$choice" -lt "$idx" ]; then
        kill_bot "${ALL_NAMES[$((choice-1))]}"
        read -p "  Press Enter to continue..."
    elif [[ "$choice" == "0" ]]; then
        return
    else
        echo -e "${RED}  Invalid option.${NC}"
        sleep 1
    fi
}

# ─────────────────────────────────────────────
menu_attach() {
    print_header
    echo -e "${BOLD}  🔗  ATTACH TO SCREEN${NC}"
    echo "  ──────────────────────────────────────"
    echo -e "  ${YELLOW}${BOLD}💡 How it works:${NC}"
    echo ""
    echo -e "  ${CYAN}  screen -r <name>${NC}  → attach to a session"
    echo ""
    echo -e "  ${CYAN}  Ctrl+A  then  D${NC}   → To detach (bot keeps running):"
    echo -e "  ${CYAN}    Step 1:${NC} Hold Ctrl + press A, release everything"
    echo -e "  ${CYAN}    Step 2:${NC} Press D alone"
    echo ""
    echo -e "  ${CYAN}  Ctrl+A  then  K${NC}   → To kill session from inside:"
    echo -e "  ${CYAN}    Step 1:${NC} Hold Ctrl + press A, release everything"
    echo -e "  ${CYAN}    Step 2:${NC} Press K alone, then press Y to confirm"
    echo "  ──────────────────────────────────────"
    echo -e "  ${BOLD}📋 Active screen sessions:${NC}"
    screen -ls | grep -E '\.' | while read line; do
        echo -e "  ${CYAN}  $line${NC}"
    done
    echo "  ──────────────────────────────────────"
    echo ""

    mapfile -t SESSIONS < <(screen -ls | grep -oP '\d+\.\S+' | sed 's/^[0-9]*\.//')

    if [ ${#SESSIONS[@]} -eq 0 ]; then
        echo -e "${YELLOW}  ⚠  No active screen sessions found.${NC}"
        echo ""
        read -p "  Press Enter to go back..."
        return
    fi

    local idx=1
    for session in "${SESSIONS[@]}"; do
        echo -e "  ${BOLD}[$idx]${NC} $session  ${GREEN}[RUNNING]${NC}"
        ((idx++))
    done

    echo ""
    echo -e "  ${BOLD}[0]${NC} Back to main menu"
    echo ""
    read -p "  Choose: " choice

    if [[ "$choice" == "0" ]]; then
        return
    elif [[ "$choice" =~ ^[0-9]+$ ]] && [ "$choice" -ge 1 ] && [ "$choice" -lt "$idx" ]; then
        local selected="${SESSIONS[$((choice-1))]}"
        echo ""
        echo -e "  ${YELLOW}▶ Running:${NC} ${CYAN}screen -r $selected${NC}"
        echo ""
        echo -e "  ${YELLOW}  To detach (bot keeps running):${NC}"
        echo -e "  ${CYAN}    Step 1:${NC} Hold Ctrl + press A, release everything"
        echo -e "  ${CYAN}    Step 2:${NC} Press D alone"
        sleep 2
        screen -r "$selected"
    else
        echo -e "${RED}  Invalid option.${NC}"
        sleep 1
    fi
}

# ─────────────────────────────────────────────
menu_resources() {
    print_header
    echo -e "${BOLD}  💻  SERVER RESOURCES${NC}"
    echo "  ──────────────────────────────────────"

    # RAM
    RAM_TOTAL=$(free -m | awk '/^Mem:/ {print $2}')
    RAM_USED=$(free -m | awk '/^Mem:/ {print $3}')
    RAM_PCT=$(awk "BEGIN {printf \"%.0f\", ($RAM_USED/$RAM_TOTAL)*100}")
    RAM_BAR=$(awk "BEGIN {n=int($RAM_PCT/5); s=\"\"; for(i=0;i<n;i++) s=s\"█\"; for(i=n;i<20;i++) s=s\"░\"; print s}")
    if [ "$RAM_PCT" -ge 85 ]; then RAM_COLOR=$RED
    elif [ "$RAM_PCT" -ge 60 ]; then RAM_COLOR=$YELLOW
    else RAM_COLOR=$GREEN; fi
    echo -e "  ${BOLD}RAM   ${NC} ${RAM_COLOR}${RAM_BAR} ${RAM_PCT}%${NC}  (${RAM_USED}MB / ${RAM_TOTAL}MB)"

    # CPU
    CPU_PCT=$(top -bn1 | grep "Cpu(s)" | awk '{print $2+$4}' | cut -d. -f1)
    CPU_BAR=$(awk "BEGIN {n=int($CPU_PCT/5); s=\"\"; for(i=0;i<n;i++) s=s\"█\"; for(i=n;i<20;i++) s=s\"░\"; print s}")
    if [ "$CPU_PCT" -ge 85 ]; then CPU_COLOR=$RED
    elif [ "$CPU_PCT" -ge 60 ]; then CPU_COLOR=$YELLOW
    else CPU_COLOR=$GREEN; fi
    echo -e "  ${BOLD}CPU   ${NC} ${CPU_COLOR}${CPU_BAR} ${CPU_PCT}%${NC}"

    # DISK
    DISK_PCT=$(df / | awk 'NR==2 {print $5}' | tr -d '%')
    DISK_USED=$(df -h / | awk 'NR==2 {print $3}')
    DISK_TOTAL=$(df -h / | awk 'NR==2 {print $2}')
    DISK_BAR=$(awk "BEGIN {n=int($DISK_PCT/5); s=\"\"; for(i=0;i<n;i++) s=s\"█\"; for(i=n;i<20;i++) s=s\"░\"; print s}")
    if [ "$DISK_PCT" -ge 85 ]; then DISK_COLOR=$RED
    elif [ "$DISK_PCT" -ge 60 ]; then DISK_COLOR=$YELLOW
    else DISK_COLOR=$GREEN; fi
    echo -e "  ${BOLD}DISK  ${NC} ${DISK_COLOR}${DISK_BAR} ${DISK_PCT}%${NC}  (${DISK_USED} / ${DISK_TOTAL})"

    # LOAD AVERAGE
    LOAD1=$(cat /proc/loadavg | awk '{print $1}')
    LOAD5=$(cat /proc/loadavg | awk '{print $2}')
    LOAD15=$(cat /proc/loadavg | awk '{print $3}')
    CPU_CORES=$(nproc)
    LOAD_PCT=$(awk "BEGIN {printf \"%.0f\", ($LOAD1/$CPU_CORES)*100}")
    LOAD_BAR=$(awk "BEGIN {n=int($LOAD_PCT/5); if(n>20) n=20; s=\"\"; for(i=0;i<n;i++) s=s\"█\"; for(i=n;i<20;i++) s=s\"░\"; print s}")
    if [ "$LOAD_PCT" -ge 85 ]; then LOAD_COLOR=$RED
    elif [ "$LOAD_PCT" -ge 60 ]; then LOAD_COLOR=$YELLOW
    else LOAD_COLOR=$GREEN; fi
    echo -e "  ${BOLD}LOAD  ${NC} ${LOAD_COLOR}${LOAD_BAR} ${LOAD_PCT}%${NC}  (1m:${LOAD1} 5m:${LOAD5} 15m:${LOAD15} | ${CPU_CORES} cores)"

    # MYSQL
    echo "  ──────────────────────────────────────"
    MYSQL_PID=$(ps aux | grep -E '[m]ariadbd|[m]ysqld' | awk '{print $2}' | head -1)
    if [ -z "$MYSQL_PID" ]; then
        echo -e "  ${BOLD}MYSQL ${NC} ${RED}[STOPPED]${NC}"
    else
        MAX_CONN=$(mysql -N -e "SHOW VARIABLES LIKE 'max_connections';" 2>/dev/null | awk '{print $2}')
        [ -z "$MAX_CONN" ] && MAX_CONN=$(grep -i max_connections /etc/mysql/my.cnf /etc/my.cnf 2>/dev/null | tail -1 | grep -oP '[0-9]+')
        [ -z "$MAX_CONN" ] && MAX_CONN=151

        CUR_CONN=$(mysql -N -e "SHOW STATUS LIKE 'Threads_connected';" 2>/dev/null | awk '{print $2}')
        if [ -z "$CUR_CONN" ]; then
            CUR_CONN=$(mysqladmin status 2>/dev/null | grep -oP 'Threads: \K[0-9]+')
        fi
        [ -z "$CUR_CONN" ] && CUR_CONN=0

        CONN_PCT=$(awk -v cur="$CUR_CONN" -v max="$MAX_CONN" 'BEGIN {printf "%.0f", (cur/max)*100}')
        CONN_BAR=$(awk -v pct="$CONN_PCT" 'BEGIN {n=int(pct/5); if(n>20) n=20; s=""; for(i=0;i<n;i++) s=s"█"; for(i=n;i<20;i++) s=s"░"; print s}')
        if [ "$CONN_PCT" -ge 85 ]; then CONN_COLOR=$RED
        elif [ "$CONN_PCT" -ge 60 ]; then CONN_COLOR=$YELLOW
        else CONN_COLOR=$GREEN; fi

        MYSQL_MEM=$(ps -p $MYSQL_PID -o %mem --no-headers | tr -d ' ' | xargs)
        MYSQL_CPU=$(ps -p $MYSQL_PID -o %cpu --no-headers | tr -d ' ' | xargs)

        MYSQL_STATUS=$(mysqladmin status 2>/dev/null)
        if [ -n "$MYSQL_STATUS" ]; then
            MYSQL_UPTIME=$(echo "$MYSQL_STATUS" | grep -oP 'Uptime: \K[0-9]+')
            MYSQL_QPS=$(echo "$MYSQL_STATUS" | grep -oP 'Queries per second avg: \K[0-9.]+')
            MYSQL_SLOW=$(echo "$MYSQL_STATUS" | grep -oP 'Slow queries: \K[0-9]+')
            UPTIME_D=$(( MYSQL_UPTIME / 86400 ))
            UPTIME_H_REM=$(( (MYSQL_UPTIME % 86400) / 3600 ))
            UPTIME_H=$(( MYSQL_UPTIME / 3600 ))
            if [ "$UPTIME_D" -ge 1 ]; then
                UPTIME_STR="${UPTIME_D}d ${UPTIME_H_REM}h"
            else
                UPTIME_STR="${UPTIME_H}h"
            fi
        fi

        READS=$(mysql -N -e "SHOW STATUS LIKE 'Innodb_buffer_pool_read_requests';" 2>/dev/null | awk '{print $2}')
        DISK_READS=$(mysql -N -e "SHOW STATUS LIKE 'Innodb_buffer_pool_reads';" 2>/dev/null | awk '{print $2}')
        if [ -n "$READS" ] && [ "$READS" -gt 0 ]; then
            CACHE_HIT=$(awk -v r="$READS" -v d="$DISK_READS" 'BEGIN {printf "%.1f", ((r-d)/r)*100}')
            if [ "$(echo "$CACHE_HIT >= 95" | bc 2>/dev/null)" = "1" ]; then CACHE_COLOR=$GREEN
            elif [ "$(echo "$CACHE_HIT >= 80" | bc 2>/dev/null)" = "1" ]; then CACHE_COLOR=$YELLOW
            else CACHE_COLOR=$RED; fi
        fi

        echo -e "  ${BOLD}MYSQL ${NC} ${GREEN}[RUNNING]${NC}  CPU:${MYSQL_CPU}%  MEM:${MYSQL_MEM}%  Up:${UPTIME_STR:-N/A}"
        echo -e "  ${BOLD}CONN  ${NC} ${CONN_COLOR}${CONN_BAR} ${CONN_PCT}%${NC}  (${CUR_CONN} / ${MAX_CONN} max connections)"
        [ -n "$CACHE_HIT" ] && echo -e "  ${BOLD}CACHE ${NC} ${CACHE_COLOR}Hit rate: ${CACHE_HIT}%${NC}  (aim for >95%)"
        echo -e "  ${BOLD}QPS   ${NC} ${CYAN}${MYSQL_QPS:-N/A}${NC} queries/sec   ${BOLD}Slow queries:${NC} ${RED}${MYSQL_SLOW:-N/A}${NC}"
    fi

    echo "  ──────────────────────────────────────"
    echo ""
    echo -e "  ${YELLOW}  Press R to refresh  |  0 to go back${NC}"
    echo ""
    read -p "  Choose: " choice
    case $choice in
        R|r) menu_resources ;;
        *) return ;;
    esac
}

# ─────────────────────────────────────────────
menu_restart() {
    while true; do
        print_header
        echo -e "${BOLD}  🔄  RESTART SERVICES${NC}"
        echo "  ──────────────────────────────────────"
        MYSQL_PID=$(ps aux | grep -E '[m]ariadbd|[m]ysqld' | awk '{print $2}' | head -1)
        if [ -n "$MYSQL_PID" ]; then MYSQL_ST="${GREEN}[RUNNING]${NC}"; else MYSQL_ST="${RED}[STOPPED]${NC}"; fi
        APACHE_PID=$(ps aux | grep -E '[a]pache2|[h]ttpd' | awk '{print $2}' | head -1)
        if [ -n "$APACHE_PID" ]; then APACHE_ST="${GREEN}[RUNNING]${NC}"; else APACHE_ST="${RED}[STOPPED]${NC}"; fi

        echo -e "  ${BOLD}[1]${NC} 🗄️  Restart MySQL / MariaDB   $(echo -e $MYSQL_ST)"
        echo -e "  ${BOLD}[2]${NC} 🌐  Restart Apache / HTTPD     $(echo -e $APACHE_ST)"
        echo -e "  ${BOLD}[3]${NC} 🔄  Restart Both"
        echo -e "  ${BOLD}[0]${NC} Back to main menu"
        echo ""
        read -p "  Choose: " choice

        case $choice in
            1)
                echo ""
                echo -e "  ${YELLOW}▶ Running:${NC} ${CYAN}systemctl restart mariadb${NC}"
                systemctl restart mariadb 2>/dev/null || systemctl restart mysql 2>/dev/null
                sleep 2
                MYSQL_PID=$(ps aux | grep -E '[m]ariadbd|[m]ysqld' | awk '{print $2}' | head -1)
                if [ -n "$MYSQL_PID" ]; then
                    echo -e "  ${GREEN}✔  MySQL / MariaDB restarted successfully!${NC}"
                else
                    echo -e "  ${RED}✘  Failed to restart MySQL / MariaDB.${NC}"
                fi
                read -p "  Press Enter to continue..."
                ;;
            2)
                echo ""
                echo -e "  ${YELLOW}▶ Running:${NC} ${CYAN}systemctl restart httpd${NC}"
                systemctl restart httpd 2>/dev/null || systemctl restart apache2 2>/dev/null
                sleep 2
                APACHE_PID=$(ps aux | grep -E '[a]pache2|[h]ttpd' | awk '{print $2}' | head -1)
                if [ -n "$APACHE_PID" ]; then
                    echo -e "  ${GREEN}✔  Apache / HTTPD restarted successfully!${NC}"
                else
                    echo -e "  ${RED}✘  Failed to restart Apache / HTTPD.${NC}"
                fi
                read -p "  Press Enter to continue..."
                ;;
            3)
                echo ""
                echo -e "  ${YELLOW}▶ Running:${NC} ${CYAN}systemctl restart mariadb && systemctl restart httpd${NC}"
                systemctl restart mariadb 2>/dev/null || systemctl restart mysql 2>/dev/null
                systemctl restart httpd 2>/dev/null || systemctl restart apache2 2>/dev/null
                sleep 2
                echo -e "  ${GREEN}✔  Both services restarted!${NC}"
                read -p "  Press Enter to continue..."
                ;;
            0) break ;;
            *)
                echo -e "${RED}  Invalid option.${NC}"
                sleep 1
                ;;
        esac
    done
}

# ─────────────────────────────────────────────
#  MAIN MENU
# ─────────────────────────────────────────────
while true; do
    print_header
    echo -e "  ${BOLD}[1]${NC} 📈  Start_Etrade_Bot"
    echo -e "  ${BOLD}[2]${NC} 🦙  Start_Alpaca_Bot"
    echo -e "  ${BOLD}[3]${NC} 🔴  Kill_Bots"
    echo -e "  ${BOLD}[4]${NC} 🔗  Attach_Screen"
    echo -e "  ${BOLD}[5]${NC} 💻  Server_Resources"
    echo -e "  ${BOLD}[6]${NC} 🔄  Restart_Services"
    echo -e "  ${BOLD}[0]${NC} 🚪  Exit"
    echo ""
    read -p "  Choose: " main_choice

    case $main_choice in
        1) menu_etrade ;;
        2) menu_alpaca ;;
        3) menu_kill_all ;;
        4) menu_attach ;;
        5) menu_resources ;;
        6) menu_restart ;;
        0)
            echo -e "${CYAN}  Bye!${NC}"
            exit 0
            ;;
        *)
            echo -e "${RED}  Invalid option.${NC}"
            sleep 1
            ;;
    esac
done
