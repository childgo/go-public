#!/bin/bash
# bash <(curl -s https://raw.githubusercontent.com/childgo/go-public/refs/heads/master/Stocks/Stock.sh)
# ═══════════════════════════════════════════════════════════════
#  ALSCO AI — TRADING BOT MANAGER
#  Supports: Etrade & Alpaca | MarketBuy & LimitBuy | Daily & SPY
# ═══════════════════════════════════════════════════════════════

clear

# ───────────────────────────────────────────────────────────────
#  SECTION 1 — TERMINAL COLORS
# ───────────────────────────────────────────────────────────────
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m'

# ───────────────────────────────────────────────────────────────
#  SECTION 2 — PATHS
# ───────────────────────────────────────────────────────────────
SCRIPT="/home/alscolive/public_html/python/trigger_allPY/Bot.py"
SCRIPT_MP="/home/alscolive/public_html/python/MarketPower/MarketPower.py"
SCRIPT_SIM="/home/alscolive/public_html/python/simulation_RealData.py"
SCRIPT_EXEC_ETRADE="/home/alscolive/public_html/python/trigger_allPY/Executing_Etrade_Daily_MarketBuy.py"
SCRIPT_EXEC_ALPACA="/home/alscolive/public_html/python/trigger_allPY/Executing_Alpaca_Daily_MarketBuy.py"
SCRIPT_LIST_STOCK="/home/alscolive/public_html/python/Stock_Monitor/ListStock.py"
SCRIPT_SPY_LEGACY="/home/alscolive/public_html/python/trigger_allPY/SPY.py"

# ───────────────────────────────────────────────────────────────
#  SECTION 3 — BOT DEFINITIONS
#  Format per entry: "ScreenName|BrokerName|MonitorStock|BuyStock"
# ───────────────────────────────────────────────────────────────

# ── Etrade Daily MarketBuy ─────────────────────────────────────
declare -A ETRADE_Daily_MarketBuy_BOTS=(
    [1]="Etrade_Daily_MarketBuy_NVDA|Etrade-Daily-MarketBuy|NVDA|NVDA"
    [2]="Etrade_Daily_MarketBuy_SPY|Etrade-Daily-MarketBuy|SPY|SPY"
    [3]="Etrade_Daily_MarketBuy_PLTR|Etrade-Daily-MarketBuy|PLTR|PLTR"
    [4]="Etrade_Daily_MarketBuy_QQQ|Etrade-Daily-MarketBuy|QQQ|QQQ"
    [5]="Etrade_Daily_MarketBuy_MSFT|Etrade-Daily-MarketBuy|MSFT|MSFT"
    [6]="Etrade_Daily_MarketBuy_AMD|Etrade-Daily-MarketBuy|AMD|AMD"
)

# ── Etrade Daily LimitBuy ──────────────────────────────────────
declare -A ETRADE_Daily_LimitBuy_BOTS=(
    [1]="Etrade_Daily_LimitBuy_NVDA|Etrade-Daily-LimitBuy|NVDA|NVDA"
    [2]="Etrade_Daily_LimitBuy_SPY|Etrade-Daily-LimitBuy|SPY|SPY"
    [3]="Etrade_Daily_LimitBuy_PLTR|Etrade-Daily-LimitBuy|PLTR|PLTR"
    [4]="Etrade_Daily_LimitBuy_QQQ|Etrade-Daily-LimitBuy|QQQ|QQQ"
    [5]="Etrade_Daily_LimitBuy_MSFT|Etrade-Daily-LimitBuy|MSFT|MSFT"
    [6]="Etrade_Daily_LimitBuy_AMD|Etrade-Daily-LimitBuy|AMD|AMD"
)

# ── Etrade SPY MarketBuy ───────────────────────────────────────
declare -A ETRADE_SPY_MarketBuy_BOTS=(
    [1]="Etrade_SPY_MarketBuy_Bot|Etrade-SPY-MarketBuy|SPY|SPY"
)

# ── Etrade SPY LimitBuy ────────────────────────────────────────
declare -A ETRADE_SPY_LimitBuy_BOTS=(
    [1]="Etrade_SPY_LimitBuy_Bot|Etrade-SPY-LimitBuy|SPY|SPY"
)

# ── Alpaca Daily MarketBuy ─────────────────────────────────────
declare -A ALPACA_Daily_MarketBuy_BOTS=(
    [1]="Alpaca_Daily_MarketBuy_SPY|Alpaca-Daily-MarketBuy|SPY|SPY"
    [2]="Alpaca_Daily_MarketBuy_QQQ|Alpaca-Daily-MarketBuy|QQQ|QQQ"
    [3]="Alpaca_Daily_MarketBuy_NVDA|Alpaca-Daily-MarketBuy|NVDA|NVDA"
    [4]="Alpaca_Daily_MarketBuy_MSFT|Alpaca-Daily-MarketBuy|MSFT|MSFT"
    [5]="Alpaca_Daily_MarketBuy_PLTR|Alpaca-Daily-MarketBuy|PLTR|PLTR"
    [6]="Alpaca_Daily_MarketBuy_AMD|Alpaca-Daily-MarketBuy|AMD|AMD"
)

# ── Alpaca Daily LimitBuy ──────────────────────────────────────
declare -A ALPACA_Daily_LimitBuy_BOTS=(
    [1]="Alpaca_Daily_LimitBuy_SPY|Alpaca-Daily-LimitBuy|SPY|SPY"
    [2]="Alpaca_Daily_LimitBuy_QQQ|Alpaca-Daily-LimitBuy|QQQ|QQQ"
    [3]="Alpaca_Daily_LimitBuy_NVDA|Alpaca-Daily-LimitBuy|NVDA|NVDA"
    [4]="Alpaca_Daily_LimitBuy_MSFT|Alpaca-Daily-LimitBuy|MSFT|MSFT"
    [5]="Alpaca_Daily_LimitBuy_PLTR|Alpaca-Daily-LimitBuy|PLTR|PLTR"
    [6]="Alpaca_Daily_LimitBuy_AMD|Alpaca-Daily-LimitBuy|AMD|AMD"
)

# ───────────────────────────────────────────────────────────────
#  SECTION 4 — CORE UTILITIES
# ───────────────────────────────────────────────────────────────

print_header() {
    clear
    echo -e "${GREEN}"
cat << "EOF"
    _    _     ____   ____ ___        _    ___   _____              _ _
   / \  | |   / ___| / ___/ _ \      / \  |_ _| |_   _| __ __ _  __| (_)_ __   __ _
  / _ \ | |   \___ \| |  | | | |    / _ \  | |    | || '__/ _` |/ _` | | '_ \ / _` |
 / ___ \| |___ ___) | |__| |_| |   / ___ \ | |    | || | | (_| | (_| | | | | | (_| |
/_/   \_\_____|____/ \____\___/   /_/   \_\___|   |_||_|  \__,_|\__,_|_|_| |_|\__, |
                                                                                |___/
EOF
    echo -e "${NC}"
    echo -e "${CYAN}${BOLD}"
    echo "  ╔══════════════════════════════════════╗"
    echo "  ║        TRADING BOT MANAGER           ║"
    echo "  ╚══════════════════════════════════════╝"
    echo -e "${NC}"
}

is_running() {
    screen -list | grep -q "$1"
}

status_icon() {
    if is_running "$1"; then
        echo -e "${GREEN}[RUNNING]${NC}"
    else
        echo -e "${RED}[STOPPED]${NC}"
    fi
}

# Extracts a field from a pipe-delimited bot entry
# Usage: bot_field "$entry" 1   (1=name, 2=broker, 3=monitor, 4=buy)
bot_field() { echo "$1" | cut -d'|' -f"$2"; }

# Sorted keys for any associative array passed by name
sorted_keys() {
    local -n _arr=$1
    echo "${!_arr[@]}" | tr ' ' '\n' | sort -n
}

# ───────────────────────────────────────────────────────────────
#  SECTION 5 — BOT ACTIONS  (start / kill)
# ───────────────────────────────────────────────────────────────

start_bot() {
    local entry=$1
    local name=$(bot_field "$entry" 1)
    local broker=$(bot_field "$entry" 2)
    local monitor=$(bot_field "$entry" 3)
    local buy=$(bot_field "$entry" 4)

    if is_running "$name"; then
        echo -e "${YELLOW}⚠  $name is already running!${NC}"
    else
        screen -dmS "$name" bash -c \
            "clear; python3 $SCRIPT 'Broker[\"$broker\"]' 'Monitor[\"$monitor\"]' 'Buy[\"$buy\"]'"
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

# Start all bots in a given associative array (by name-ref)
start_all_bots() {
    local -n _bots=$1
    for key in $(sorted_keys _bots); do
        start_bot "${_bots[$key]}"
    done
}

# Kill all bots in a given associative array (by name-ref)
kill_all_bots() {
    local -n _bots=$1
    for key in $(sorted_keys _bots); do
        kill_bot "$(bot_field "${_bots[$key]}" 1)"
    done
}

# ───────────────────────────────────────────────────────────────
#  SECTION 6 — GENERIC BOT GROUP MENU
#  Reusable function — avoids copy-pasting the same menu 6 times
#
#  Usage: bot_group_menu  "ARRAY_NAME"  "📈  LABEL"
# ───────────────────────────────────────────────────────────────

bot_group_menu() {
    local arr_name=$1
    local label=$2
    local -n _bots=$arr_name

    while true; do
        print_header
        echo -e "${BOLD}  $label${NC}"
        echo "  ──────────────────────────────────────"
        printf "  ${BOLD}%-4s  %-38s %-12s %-14s${NC}\n" "No." "Screen Name" "Monitor" "Status"
        echo "  ──────────────────────────────────────"

        for key in $(sorted_keys _bots); do
            local entry="${_bots[$key]}"
            local name=$(bot_field "$entry" 1)
            local monitor=$(bot_field "$entry" 3)
            local buy=$(bot_field "$entry" 4)
            printf "  ${BOLD}[%-1s]${NC}  %-38s ${CYAN}|%-4s|%-4s${NC}  %s\n" \
                "$key" "$name" "$monitor" "$buy" "$(status_icon "$name")"
        done

        echo ""
        echo -e "  ${BOLD}[A]${NC} Start ALL"
        echo -e "  ${BOLD}[K]${NC} Kill a specific bot"
        echo -e "  ${BOLD}[0]${NC} Back to main menu"
        echo ""
        read -p "  Choose: " choice

        case $choice in
            [1-9])
                local entry="${_bots[$choice]}"
                if [ -n "$entry" ]; then
                    start_bot "$entry"
                    read -p "  Press Enter to continue..."
                fi
                ;;
            A|a) start_all_bots _bots; read -p "  Press Enter to continue..." ;;
            K|k) bot_kill_menu "$arr_name" "$label" ;;
            0)   break ;;
            *)   echo -e "${RED}  Invalid option.${NC}"; sleep 1 ;;
        esac
    done
}

# ───────────────────────────────────────────────────────────────
#  SECTION 7 — GENERIC KILL MENU  (per group)
# ───────────────────────────────────────────────────────────────

bot_kill_menu() {
    local arr_name=$1
    local label=$2
    local -n _bots=$arr_name

    print_header
    echo -e "${BOLD}  🔴  KILL — $label${NC}"
    echo "  ──────────────────────────────────────"

    # Build list of ONLY running bots with sequential numbers
    local RUNNING_NAMES=()
    local idx=1
    for key in $(sorted_keys _bots); do
        local name=$(bot_field "${_bots[$key]}" 1)
        if is_running "$name"; then
            RUNNING_NAMES+=("$name")
            echo -e "  ${BOLD}[$idx]${NC} $name  ${GREEN}[RUNNING]${NC}"
            ((idx++))
        fi
    done

    if [ ${#RUNNING_NAMES[@]} -eq 0 ]; then
        echo -e "  ${YELLOW}  ⚠  No running bots in this group.${NC}"
        echo ""
        read -p "  Press Enter to go back..."
        return
    fi

    echo ""
    echo -e "  ${BOLD}[A]${NC} Kill ALL running"
    echo -e "  ${BOLD}[0]${NC} Back"
    echo ""
    read -p "  Choose: " choice

    case "${choice^^}" in
        A)
            for name in "${RUNNING_NAMES[@]}"; do kill_bot "$name"; done
            read -p "  Press Enter to continue..."
            ;;
        0) return ;;
        *)
            if [[ "$choice" =~ ^[0-9]+$ ]] && (( choice >= 1 && choice < idx )); then
                kill_bot "${RUNNING_NAMES[$((choice-1))]}"
                read -p "  Press Enter to continue..."
            else
                echo -e "${RED}  Invalid option.${NC}"; sleep 1
            fi
            ;;
    esac
}

# ───────────────────────────────────────────────────────────────
#  SECTION 8 — KILL ALL BOTS  (master kill screen)
# ───────────────────────────────────────────────────────────────

menu_kill_all() {
    # Build a flat list of ONLY running bots across all groups
    local ALL_NAMES=()
    local idx=1
    local any_running=false

    _print_group_kill_section() {
        local arr_name=$1 label=$2
        local -n _g=$arr_name
        local group_header_printed=false

        for key in $(sorted_keys _g); do
            local name=$(bot_field "${_g[$key]}" 1)
            if is_running "$name"; then
                if ! $group_header_printed; then
                    echo -e "  ${CYAN}${BOLD}  $label${NC}"
                    group_header_printed=true
                fi
                ALL_NAMES+=("$name")
                echo -e "  ${BOLD}[$idx]${NC} $name  ${GREEN}[RUNNING]${NC}"
                ((idx++))
                any_running=true
            fi
        done
        $group_header_printed && echo ""
    }

    print_header
    echo -e "${BOLD}  🔴  KILL BOTS  ${YELLOW}(showing running only)${NC}"
    echo "  ──────────────────────────────────────"

    _print_group_kill_section ETRADE_Daily_MarketBuy_BOTS "📈  ETRADE-DAILY-MARKETBUY"
    _print_group_kill_section ALPACA_Daily_MarketBuy_BOTS "🦙  ALPACA-DAILY-MARKETBUY"
    _print_group_kill_section ETRADE_SPY_MarketBuy_BOTS   "📊  ETRADE-SPY-MARKETBUY"
    _print_group_kill_section ETRADE_Daily_LimitBuy_BOTS  "📈  ETRADE-DAILY-LIMITBUY"
    _print_group_kill_section ALPACA_Daily_LimitBuy_BOTS  "🦙  ALPACA-DAILY-LIMITBUY"
    _print_group_kill_section ETRADE_SPY_LimitBuy_BOTS    "📊  ETRADE-SPY-LIMITBUY"

    if ! $any_running; then
        echo -e "  ${YELLOW}  ⚠  No bots are currently running.${NC}"
        echo ""
        read -p "  Press Enter to go back..."
        return
    fi

    echo -e "  ${BOLD}[E]${NC} 📈  Kill ALL Etrade-Daily-MarketBuy"
    echo -e "  ${BOLD}[P]${NC} 🦙  Kill ALL Alpaca-Daily-MarketBuy"
    echo -e "  ${BOLD}[S]${NC} 📊  Kill ALL Etrade-SPY-MarketBuy"
    echo -e "  ${BOLD}[L]${NC} 📈  Kill ALL Etrade-Daily-LimitBuy"
    echo -e "  ${BOLD}[B]${NC} 🦙  Kill ALL Alpaca-Daily-LimitBuy"
    echo -e "  ${BOLD}[Y]${NC} 📊  Kill ALL Etrade-SPY-LimitBuy"
    echo -e "  ${BOLD}[A]${NC} 💀  Kill ALL running bots"
    echo -e "  ${BOLD}[0]${NC} Back to main menu"
    echo ""
    read -p "  Choose: " choice

    case "${choice^^}" in
        A) for name in "${ALL_NAMES[@]}"; do kill_bot "$name"; done ;;
        E) kill_all_bots ETRADE_Daily_MarketBuy_BOTS ;;
        P) kill_all_bots ALPACA_Daily_MarketBuy_BOTS ;;
        S) kill_all_bots ETRADE_SPY_MarketBuy_BOTS   ;;
        L) kill_all_bots ETRADE_Daily_LimitBuy_BOTS  ;;
        B) kill_all_bots ALPACA_Daily_LimitBuy_BOTS  ;;
        Y) kill_all_bots ETRADE_SPY_LimitBuy_BOTS    ;;
        0) return ;;
        *)
            if [[ "$choice" =~ ^[0-9]+$ ]] && (( choice >= 1 && choice < idx )); then
                kill_bot "${ALL_NAMES[$((choice-1))]}"
            else
                echo -e "${RED}  Invalid option.${NC}"; sleep 1; return
            fi
            ;;
    esac
    read -p "  Press Enter to continue..."
}

# ───────────────────────────────────────────────────────────────
#  SECTION 9 — ATTACH TO SCREEN
# ───────────────────────────────────────────────────────────────

menu_attach() {
    print_header
    echo -e "${BOLD}  🔗  ATTACH TO SCREEN${NC}"
    echo "  ──────────────────────────────────────"
    echo -e "  ${YELLOW}${BOLD}💡 How it works:${NC}"
    echo -e "  ${CYAN}  screen -r <name>${NC}  → attach to a session"
    echo -e "  ${CYAN}  Ctrl+A then D${NC}     → detach  (bot keeps running)"
    echo -e "  ${CYAN}  Ctrl+A then K${NC}     → kill session from inside"
    echo "  ──────────────────────────────────────"
    echo ""

    mapfile -t SESSIONS < <(screen -ls | grep -oP '\d+\.\S+' | sed 's/^[0-9]*\.//')

    if [ ${#SESSIONS[@]} -eq 0 ]; then
        echo -e "${YELLOW}  ⚠  No active screen sessions found.${NC}"
        echo ""
        read -p "  Press Enter to go back..."
        return
    fi

    # ── Categorise sessions ───────────────────────────────────
    local ETRADE_DAILY_MB=() ETRADE_DAILY_LB=() ETRADE_SPY_MB=() ETRADE_SPY_LB=()
    local ALPACA_MB=() ALPACA_LB=() OTHER=()

    for s in "${SESSIONS[@]}"; do
        case "$s" in
            Etrade_Daily_MarketBuy_*) ETRADE_DAILY_MB+=("$s") ;;
            Etrade_Daily_LimitBuy_*)  ETRADE_DAILY_LB+=("$s") ;;
            Etrade_SPY_MarketBuy_*)   ETRADE_SPY_MB+=("$s")   ;;
            Etrade_SPY_LimitBuy_*)    ETRADE_SPY_LB+=("$s")   ;;
            Alpaca_Daily_MarketBuy_*) ALPACA_MB+=("$s")       ;;
            Alpaca_Daily_LimitBuy_*)  ALPACA_LB+=("$s")       ;;
            *)                        OTHER+=("$s")            ;;
        esac
    done

    # ── Print sessions grouped, numbered ─────────────────────
    local ALL_ORDERED=()
    local idx=1

    _print_attach_group() {
        local label=$1; shift
        local sessions=("$@")
        [ ${#sessions[@]} -eq 0 ] && return
        echo -e "  ${CYAN}${BOLD}  $label${NC}"
        for s in "${sessions[@]}"; do
            ALL_ORDERED+=("$s")
            local STATUS PID ST_COLOR
            STATUS=$(screen -ls | grep "$s" | grep -oP '(Attached|Detached)')
            PID=$(screen -ls | grep "$s" | grep -oP '^\s*\K[0-9]+')
            [ "$STATUS" = "Attached" ] && ST_COLOR=$GREEN || ST_COLOR=$YELLOW
            echo -e "  ${BOLD}[$idx]${NC} $s  ${GREEN}[RUNNING]${NC}  ${ST_COLOR}($STATUS)${NC}  ${CYAN}pid:$PID${NC}"
            ((idx++))
        done
        echo ""
    }

    _print_attach_group "📈  ETRADE-DAILY-MARKETBUY" "${ETRADE_DAILY_MB[@]}"
    _print_attach_group "📊  ETRADE-SPY-MARKETBUY"   "${ETRADE_SPY_MB[@]}"
    _print_attach_group "🦙  ALPACA-DAILY-MARKETBUY"  "${ALPACA_MB[@]}"
    _print_attach_group "📈  ETRADE-DAILY-LIMITBUY"   "${ETRADE_DAILY_LB[@]}"
    _print_attach_group "📊  ETRADE-SPY-LIMITBUY"     "${ETRADE_SPY_LB[@]}"
    _print_attach_group "🦙  ALPACA-DAILY-LIMITBUY"   "${ALPACA_LB[@]}"
    _print_attach_group "⚙️   OTHER"                   "${OTHER[@]}"

    echo -e "  ${BOLD}[0]${NC} Back to main menu"
    echo ""
    read -p "  Choose: " choice

    if [[ "$choice" == "0" ]]; then
        return
    elif [[ "$choice" =~ ^[0-9]+$ ]] && (( choice >= 1 && choice < idx )); then
        local selected="${ALL_ORDERED[$((choice-1))]}"
        echo -e "\n  ${YELLOW}▶ Attaching to:${NC} ${CYAN}screen -x $selected${NC}"
        echo -e "  ${YELLOW}  Detach: Ctrl+A then D${NC}"
        sleep 2
        screen -x "$selected"
    else
        echo -e "${RED}  Invalid option.${NC}"; sleep 1
    fi
}

# ───────────────────────────────────────────────────────────────
#  SECTION 10 — SERVER RESOURCES
# ───────────────────────────────────────────────────────────────

_make_bar() {
    # _make_bar  PCT  [max_blocks=20]
    local pct=$1 max=${2:-20}
    local n=$(( pct * max / 100 ))
    (( n > max )) && n=$max
    awk -v n="$n" -v max="$max" 'BEGIN{s="";for(i=0;i<n;i++)s=s"█";for(i=n;i<max;i++)s=s"░";print s}'
}

_bar_color() {
    local pct=$1
    if   (( pct >= 85 )); then echo "$RED"
    elif (( pct >= 60 )); then echo "$YELLOW"
    else                       echo "$GREEN"
    fi
}

menu_resources() {
    print_header
    echo -e "${BOLD}  💻  SERVER RESOURCES${NC}"
    echo "  ──────────────────────────────────────"

    # RAM
    local RAM_TOTAL RAM_USED RAM_PCT
    RAM_TOTAL=$(free -m | awk '/^Mem:/{print $2}')
    RAM_USED=$(free -m  | awk '/^Mem:/{print $3}')
    RAM_PCT=$(awk "BEGIN{printf \"%.0f\",($RAM_USED/$RAM_TOTAL)*100}")
    echo -e "  ${BOLD}RAM   ${NC} $(_bar_color $RAM_PCT)$(_make_bar $RAM_PCT) ${RAM_PCT}%${NC}  (${RAM_USED}MB / ${RAM_TOTAL}MB)"

    # CPU
    local CPU_PCT
    CPU_PCT=$(top -bn1 | grep "Cpu(s)" | awk '{print $2+$4}' | cut -d. -f1)
    echo -e "  ${BOLD}CPU   ${NC} $(_bar_color $CPU_PCT)$(_make_bar $CPU_PCT) ${CPU_PCT}%${NC}"

    # DISK
    local DISK_PCT DISK_USED DISK_TOTAL
    DISK_PCT=$(df /   | awk 'NR==2{print $5}' | tr -d '%')
    DISK_USED=$(df -h / | awk 'NR==2{print $3}')
    DISK_TOTAL=$(df -h / | awk 'NR==2{print $2}')
    echo -e "  ${BOLD}DISK  ${NC} $(_bar_color $DISK_PCT)$(_make_bar $DISK_PCT) ${DISK_PCT}%${NC}  (${DISK_USED} / ${DISK_TOTAL})"

    # LOAD
    local LOAD1 LOAD5 LOAD15 CPU_CORES LOAD_PCT
    read LOAD1 LOAD5 LOAD15 _ < /proc/loadavg
    CPU_CORES=$(nproc)
    LOAD_PCT=$(awk "BEGIN{printf \"%.0f\",($LOAD1/$CPU_CORES)*100}")
    echo -e "  ${BOLD}LOAD  ${NC} $(_bar_color $LOAD_PCT)$(_make_bar $LOAD_PCT) ${LOAD_PCT}%${NC}  (1m:${LOAD1} 5m:${LOAD5} 15m:${LOAD15} | ${CPU_CORES} cores)"

    # MySQL / MariaDB
    echo "  ──────────────────────────────────────"
    local MYSQL_PID
    MYSQL_PID=$(pgrep -x mariadbd || pgrep -x mysqld | head -1)

    if [ -z "$MYSQL_PID" ]; then
        echo -e "  ${BOLD}MYSQL ${NC} ${RED}[STOPPED]${NC}"
    else
        local MAX_CONN CUR_CONN CONN_PCT MYSQL_MEM MYSQL_CPU
        MAX_CONN=$(mysql -N -e "SHOW VARIABLES LIKE 'max_connections';" 2>/dev/null | awk '{print $2}')
        [ -z "$MAX_CONN" ] && MAX_CONN=$(grep -i max_connections /etc/mysql/my.cnf /etc/my.cnf 2>/dev/null | tail -1 | grep -oP '[0-9]+')
        [ -z "$MAX_CONN" ] && MAX_CONN=151
        CUR_CONN=$(mysql -N -e "SHOW STATUS LIKE 'Threads_connected';" 2>/dev/null | awk '{print $2}')
        [ -z "$CUR_CONN" ] && CUR_CONN=$(mysqladmin status 2>/dev/null | grep -oP 'Threads: \K[0-9]+')
        [ -z "$CUR_CONN" ] && CUR_CONN=0
        CONN_PCT=$(awk -v c="$CUR_CONN" -v m="$MAX_CONN" 'BEGIN{printf "%.0f",(c/m)*100}')
        MYSQL_MEM=$(ps -p "$MYSQL_PID" -o %mem --no-headers | tr -d ' ' | xargs)
        MYSQL_CPU=$(ps -p "$MYSQL_PID" -o %cpu --no-headers | tr -d ' ' | xargs)

        local UPTIME_STR="N/A" MYSQL_QPS="N/A" MYSQL_SLOW="N/A"
        local MYSQL_STATUS
        MYSQL_STATUS=$(mysqladmin status 2>/dev/null)
        if [ -n "$MYSQL_STATUS" ]; then
            local MYSQL_UPTIME UPTIME_D UPTIME_H
            MYSQL_UPTIME=$(echo "$MYSQL_STATUS" | grep -oP 'Uptime: \K[0-9]+')
            MYSQL_QPS=$(echo "$MYSQL_STATUS"    | grep -oP 'Queries per second avg: \K[0-9.]+')
            MYSQL_SLOW=$(echo "$MYSQL_STATUS"   | grep -oP 'Slow queries: \K[0-9]+')
            UPTIME_D=$(( MYSQL_UPTIME / 86400 ))
            UPTIME_H=$(( (MYSQL_UPTIME % 86400) / 3600 ))
            [ "$UPTIME_D" -ge 1 ] && UPTIME_STR="${UPTIME_D}d ${UPTIME_H}h" || UPTIME_STR="${UPTIME_H}h"
        fi

        local CACHE_HIT="" CACHE_COLOR=$GREEN
        local READS DISK_READS
        READS=$(mysql -N -e "SHOW STATUS LIKE 'Innodb_buffer_pool_read_requests';" 2>/dev/null | awk '{print $2}')
        DISK_READS=$(mysql -N -e "SHOW STATUS LIKE 'Innodb_buffer_pool_reads';" 2>/dev/null | awk '{print $2}')
        if [ -n "$READS" ] && (( READS > 0 )); then
            CACHE_HIT=$(awk -v r="$READS" -v d="$DISK_READS" 'BEGIN{printf "%.1f",((r-d)/r)*100}')
            [ "$(echo "$CACHE_HIT < 80" | bc 2>/dev/null)" = "1" ] && CACHE_COLOR=$RED \
            || { [ "$(echo "$CACHE_HIT < 95" | bc 2>/dev/null)" = "1" ] && CACHE_COLOR=$YELLOW; }
        fi

        echo -e "  ${BOLD}MYSQL ${NC} ${GREEN}[RUNNING]${NC}  CPU:${MYSQL_CPU}%  MEM:${MYSQL_MEM}%  Up:${UPTIME_STR}"
        echo -e "  ${BOLD}CONN  ${NC} $(_bar_color $CONN_PCT)$(_make_bar $CONN_PCT) ${CONN_PCT}%${NC}  (${CUR_CONN} / ${MAX_CONN})"
        [ -n "$CACHE_HIT" ] && echo -e "  ${BOLD}CACHE ${NC} ${CACHE_COLOR}Hit rate: ${CACHE_HIT}%${NC}  (aim >95%)"
        echo -e "  ${BOLD}QPS   ${NC} ${CYAN}${MYSQL_QPS}${NC} q/s   ${BOLD}Slow queries:${NC} ${RED}${MYSQL_SLOW}${NC}"
    fi

    echo "  ──────────────────────────────────────"
    echo ""
    echo -e "  ${YELLOW}  [R] Refresh  |  [0] Back${NC}"
    echo ""
    read -p "  Choose: " choice
    case "${choice^^}" in
        R) menu_resources ;;
        *) return ;;
    esac
}

# ───────────────────────────────────────────────────────────────
#  SECTION 11 — RESTART SERVICES
# ───────────────────────────────────────────────────────────────

menu_restart() {
    while true; do
        print_header
        echo -e "${BOLD}  🔄  RESTART SERVICES${NC}"
        echo "  ──────────────────────────────────────"

        local MYSQL_ST APACHE_ST
        pgrep -x mariadbd &>/dev/null || pgrep -x mysqld &>/dev/null \
            && MYSQL_ST="${GREEN}[RUNNING]${NC}" || MYSQL_ST="${RED}[STOPPED]${NC}"
        pgrep -x apache2 &>/dev/null || pgrep -x httpd &>/dev/null \
            && APACHE_ST="${GREEN}[RUNNING]${NC}" || APACHE_ST="${RED}[STOPPED]${NC}"

        echo -e "  ${BOLD}[1]${NC} 🗄️  Restart MySQL / MariaDB   $(echo -e $MYSQL_ST)"
        echo -e "  ${BOLD}[2]${NC} 🌐  Restart Apache / HTTPD     $(echo -e $APACHE_ST)"
        echo -e "  ${BOLD}[3]${NC} 🔄  Restart Both"
        echo -e "  ${BOLD}[0]${NC} Back to main menu"
        echo ""
        read -p "  Choose: " choice

        case $choice in
            1)
                echo -e "\n  ${YELLOW}▶ Running:${NC} ${CYAN}systemctl restart mariadb${NC}"
                systemctl restart mariadb 2>/dev/null || systemctl restart mysql 2>/dev/null
                sleep 2
                pgrep -x mariadbd &>/dev/null || pgrep -x mysqld &>/dev/null \
                    && echo -e "  ${GREEN}✔  MySQL / MariaDB restarted!${NC}" \
                    || echo -e "  ${RED}✘  Failed to restart MySQL / MariaDB.${NC}"
                read -p "  Press Enter to continue..."
                ;;
            2)
                echo -e "\n  ${YELLOW}▶ Running:${NC} ${CYAN}systemctl restart httpd${NC}"
                systemctl restart httpd 2>/dev/null || systemctl restart apache2 2>/dev/null
                sleep 2
                pgrep -x apache2 &>/dev/null || pgrep -x httpd &>/dev/null \
                    && echo -e "  ${GREEN}✔  Apache / HTTPD restarted!${NC}" \
                    || echo -e "  ${RED}✘  Failed to restart Apache / HTTPD.${NC}"
                read -p "  Press Enter to continue..."
                ;;
            3)
                echo -e "\n  ${YELLOW}▶ Running:${NC} ${CYAN}systemctl restart mariadb && systemctl restart httpd${NC}"
                systemctl restart mariadb 2>/dev/null || systemctl restart mysql 2>/dev/null
                systemctl restart httpd 2>/dev/null   || systemctl restart apache2 2>/dev/null
                sleep 2
                echo -e "  ${GREEN}✔  Both services restarted!${NC}"
                read -p "  Press Enter to continue..."
                ;;
            0) break ;;
            *) echo -e "${RED}  Invalid option.${NC}"; sleep 1 ;;
        esac
    done
}

# ───────────────────────────────────────────────────────────────
#  SECTION 12 — CHEATSHEET
# ───────────────────────────────────────────────────────────────

menu_cheatsheet() {
    while true; do
        print_header
        echo -e "${BOLD}  📋  QUICK REFERENCE / CHEATSHEET${NC}"
        echo "  ──────────────────────────────────────"

        echo -e "${CYAN}${BOLD}  # Verify Sessions${NC}"
        echo -e "  ${YELLOW}[1]${NC} ${GREEN}clear; screen -ls${NC}"
        echo -e "  ${YELLOW}[2]${NC} ${GREEN}clear; ps aux | grep python${NC}"
        echo ""

        echo -e "${CYAN}${BOLD}  # Screen Keyboard Shortcuts${NC}"
        echo -e "  ${CYAN}  Ctrl+A then D${NC}  → detach  (bot keeps running)"
        echo -e "  ${CYAN}  Ctrl+A then K${NC}  → kill session from inside (confirm with Y)"
        echo ""

        echo -e "${CYAN}${BOLD}  # Kill All Screens${NC}"
        echo -e "  ${YELLOW}[3]${NC} ${GREEN}pkill screen${NC}"
        echo ""

        echo -e "${CYAN}${BOLD}  # Open / Re-attach a Screen${NC}"
        echo -e "  ${YELLOW}[4]${NC} ${GREEN}screen -r Etrade_Daily_MarketBuy_NVDA${NC}"
        echo -e "  ${YELLOW}[5]${NC} ${GREEN}screen -S SPY -dm python3 $SCRIPT_SPY_LEGACY${NC}"
        echo ""

        echo -e "${CYAN}${BOLD}  # Direct Run (no screen) — Etrade${NC}"
        echo -e "  ${YELLOW}[6]${NC} ${GREEN}clear; python3 $SCRIPT Broker[\"Etrade-Daily-MarketBuy\"] Monitor[NVDA] Buy[NVDA]${NC}"
        echo -e "  ${YELLOW}[7]${NC} ${GREEN}clear; python3 $SCRIPT Broker[\"Etrade-Daily-MarketBuy\"] Monitor[NVDA,AMD] Buy[NVDA,AMD]${NC}"
        echo ""

        echo -e "${CYAN}${BOLD}  # Direct Run (no screen) — Alpaca${NC}"
        echo -e "  ${YELLOW}[8]${NC} ${GREEN}clear; python3 $SCRIPT Broker[\"Alpaca-Daily-MarketBuy\"] Monitor[NVDA] Buy[NVDA]${NC}"
        echo -e "  ${YELLOW}[9]${NC} ${GREEN}clear; python3 $SCRIPT Broker[\"Alpaca-Daily-MarketBuy\"] Monitor[NVDA,AMD] Buy[NVDA,AMD]${NC}"
        echo ""

        echo -e "${CYAN}${BOLD}  # Start in Screen (background)${NC}"
        echo -e "  ${YELLOW}[10]${NC} ${GREEN}screen -dmS Etrade_Daily_MarketBuy_NVDA bash -c 'clear; python3 $SCRIPT Broker[\"Etrade-Daily-MarketBuy\"] Monitor[NVDA] Buy[NVDA]'${NC}"
        echo ""

        echo -e "${CYAN}${BOLD}  # Run Executor Scripts Directly${NC}"
        echo -e "  ${YELLOW}[11]${NC} ${GREEN}clear; python3 $SCRIPT_EXEC_ETRADE NVDA 1 0.01${NC}"
        echo -e "  ${YELLOW}[12]${NC} ${GREEN}clear; python3 $SCRIPT_EXEC_ALPACA NVDA 1 0.01${NC}"
        echo ""

        echo -e "${CYAN}${BOLD}  # Other Tools${NC}"
        echo -e "  ${YELLOW}[13]${NC} ${GREEN}clear; python3 $SCRIPT_MP${NC}  (MarketPower)"
        echo -e "  ${YELLOW}[14]${NC} ${GREEN}clear; python3 $SCRIPT_LIST_STOCK${NC}  (ListStock & Balance)"
        echo ""

        echo "  ──────────────────────────────────────"
        echo -e "  ${BOLD}[0]${NC} Back to main menu"
        echo ""
        read -p "  Choose (0 to go back): " choice

        case $choice in
            1)  clear; screen -ls ;;
            2)  clear; ps aux | grep python ;;
            3)  pkill screen && echo -e "${RED}✘  All screens killed.${NC}" ;;
            4)  screen -r Etrade_Daily_MarketBuy_NVDA ;;
            5)  screen -S SPY -dm python3 "$SCRIPT_SPY_LEGACY"
                echo -e "${GREEN}✔  screen SPY started.${NC}" ;;
            6)  clear; python3 $SCRIPT 'Broker["Etrade-Daily-MarketBuy"]' 'Monitor["NVDA"]'     'Buy["NVDA"]' ;;
            7)  clear; python3 $SCRIPT 'Broker["Etrade-Daily-MarketBuy"]' 'Monitor["NVDA,AMD"]' 'Buy["NVDA,AMD"]' ;;
            8)  clear; python3 $SCRIPT 'Broker["Alpaca-Daily-MarketBuy"]' 'Monitor["NVDA"]'     'Buy["NVDA"]' ;;
            9)  clear; python3 $SCRIPT 'Broker["Alpaca-Daily-MarketBuy"]' 'Monitor["NVDA,AMD"]' 'Buy["NVDA,AMD"]' ;;
            10) screen -dmS Etrade_Daily_MarketBuy_NVDA bash -c \
                    "clear; python3 $SCRIPT 'Broker[\"Etrade-Daily-MarketBuy\"]' 'Monitor[\"NVDA\"]' 'Buy[\"NVDA\"]'" ;;
            11) clear; python3 "$SCRIPT_EXEC_ETRADE" NVDA 1 0.01 ;;
            12) clear; python3 "$SCRIPT_EXEC_ALPACA" NVDA 1 0.01 ;;
            13) clear; python3 "$SCRIPT_MP" ;;
            14) clear; python3 "$SCRIPT_LIST_STOCK" ;;
            0)  return ;;
            *)  echo -e "${RED}  Invalid option.${NC}"; sleep 1; continue ;;
        esac

        echo ""
        read -p "  Press Enter to return to cheatsheet..."
    done
}

# ───────────────────────────────────────────────────────────────
#  SECTION 13 — SINGLE-PROCESS TOOL MENU  (MarketPower / Simulation)
#  Reusable: _tool_menu "ScreenName" "script_path" "Label" [extra_arg_for_direct_run]
# ───────────────────────────────────────────────────────────────

_tool_menu() {
    local NAME=$1 SCRIPT_PATH=$2 LABEL=$3 DIRECT_ARG=${4:-""}

    print_header
    echo -e "${BOLD}  $LABEL${NC}"
    echo "  ──────────────────────────────────────"
    echo ""

    if screen -list | grep -q "$NAME"; then
        echo -e "  Status: ${GREEN}[RUNNING]${NC}"
    else
        echo -e "  Status: ${RED}[STOPPED]${NC}"
    fi

    echo ""
    echo -e "  ${BOLD}[1]${NC} ▶  Start (background screen)"
    echo -e "  ${BOLD}[2]${NC} 🔴  Stop"
    echo -e "  ${BOLD}[3]${NC} 🖥️  Run directly in this terminal"
    [ "$NAME" = "MarketPower" ] && echo -e "  ${BOLD}[4]${NC} 🔗  Attach to screen"
    echo -e "  ${BOLD}[0]${NC} Back to main menu"
    echo ""
    read -p "  Choose: " choice

    case $choice in
        1)
            if screen -list | grep -q "$NAME"; then
                echo -e "${YELLOW}⚠  $NAME is already running!${NC}"
            else
                screen -dmS "$NAME" bash -c "clear; python3 $SCRIPT_PATH $DIRECT_ARG"
                sleep 0.5
                screen -list | grep -q "$NAME" \
                    && echo -e "${GREEN}✔  $NAME started!${NC}" \
                    || echo -e "${RED}✘  Failed to start $NAME.${NC}"
            fi
            read -p "  Press Enter to continue..."
            _tool_menu "$NAME" "$SCRIPT_PATH" "$LABEL" "$DIRECT_ARG"
            ;;
        2)
            if screen -list | grep -q "$NAME"; then
                screen -S "$NAME" -X quit 2>/dev/null
                pkill -f "$(basename "$SCRIPT_PATH")" 2>/dev/null
                sleep 0.3
                echo -e "${RED}✘  $NAME stopped.${NC}"
            else
                echo -e "${YELLOW}⚠  $NAME is not running.${NC}"
            fi
            read -p "  Press Enter to continue..."
            _tool_menu "$NAME" "$SCRIPT_PATH" "$LABEL" "$DIRECT_ARG"
            ;;
        3)
            echo -e "\n  ${YELLOW}▶ Running directly. Press Ctrl+C to stop.${NC}\n"
            sleep 1; clear
            python3 "$SCRIPT_PATH" ${DIRECT_ARG:+AutoSelectDB_Yes}
            echo ""
            read -p "  Ended. Press Enter to continue..."
            _tool_menu "$NAME" "$SCRIPT_PATH" "$LABEL" "$DIRECT_ARG"
            ;;
        4)
            if screen -list | grep -q "$NAME"; then
                echo -e "\n  ${YELLOW}▶ Attaching to ${CYAN}$NAME${NC}  (Ctrl+A then D to detach)"
                sleep 2; screen -x "$NAME"
                _tool_menu "$NAME" "$SCRIPT_PATH" "$LABEL" "$DIRECT_ARG"
            else
                echo -e "${YELLOW}⚠  $NAME is not running.${NC}"
                read -p "  Press Enter to continue..."
                _tool_menu "$NAME" "$SCRIPT_PATH" "$LABEL" "$DIRECT_ARG"
            fi
            ;;
        0) return ;;
        *) echo -e "${RED}  Invalid option.${NC}"; sleep 1
           _tool_menu "$NAME" "$SCRIPT_PATH" "$LABEL" "$DIRECT_ARG" ;;
    esac
}

# ───────────────────────────────────────────────────────────────
#  SECTION 14 — MAIN MENU
# ───────────────────────────────────────────────────────────────

while true; do
    print_header
    # ── MarketBuy Bots ──────────────────────────────────────────
    echo -e "  ${CYAN}${BOLD}  ── MarketBuy ──────────────────────────${NC}"
    echo -e "  ${BOLD}[1]${NC} 📈  Etrade  Daily  MarketBuy  bots"
    echo -e "  ${BOLD}[2]${NC} 🦙  Alpaca  Daily  MarketBuy  bots"
    echo -e "  ${BOLD}[3]${NC} 📊  Etrade  SPY    MarketBuy  bots"
    echo ""
    # ── LimitBuy Bots ───────────────────────────────────────────
    echo -e "  ${CYAN}${BOLD}  ── LimitBuy ───────────────────────────${NC}"
    echo -e "  ${BOLD}[4]${NC} 📈  Etrade  Daily  LimitBuy   bots"
    echo -e "  ${BOLD}[5]${NC} 🦙  Alpaca  Daily  LimitBuy   bots"
    echo -e "  ${BOLD}[6]${NC} 📊  Etrade  SPY    LimitBuy   bots"
    echo "  ──────────────────────────────────────"
    # ── Management ─────────────────────────────────────────────
    echo -e "  ${BOLD}[7]${NC} 🔴  Kill Bots"
    echo -e "  ${BOLD}[8]${NC} 🔗  Attach to Screen"
    echo -e "  ${BOLD}[9]${NC} 💻  Server Resources"
    echo -e "  ${BOLD}[10]${NC} 🔄  Restart Services"
    echo -e "  ${BOLD}[11]${NC} 📋  Cheatsheet"
    echo "  ──────────────────────────────────────"
    # ── Tools ───────────────────────────────────────────────────
    echo -e "  ${BOLD}[12]${NC} ⚡  Market Power"
    echo -e "  ${BOLD}[13]${NC} 🧪  Data Simulation"
    echo "  ──────────────────────────────────────"
    echo -e "  ${BOLD}[0]${NC} 🚪  Exit"
    echo ""
    read -p "  Choose: " main_choice

    case $main_choice in
        1)  bot_group_menu ETRADE_Daily_MarketBuy_BOTS "📈  ETRADE-DAILY-MARKETBUY BOTS" ;;
        2)  bot_group_menu ALPACA_Daily_MarketBuy_BOTS "🦙  ALPACA-DAILY-MARKETBUY BOTS" ;;
        3)  bot_group_menu ETRADE_SPY_MarketBuy_BOTS   "📊  ETRADE-SPY-MARKETBUY BOTS"   ;;
        4)  bot_group_menu ETRADE_Daily_LimitBuy_BOTS  "📈  ETRADE-DAILY-LIMITBUY BOTS"  ;;
        5)  bot_group_menu ALPACA_Daily_LimitBuy_BOTS  "🦙  ALPACA-DAILY-LIMITBUY BOTS"  ;;
        6)  bot_group_menu ETRADE_SPY_LimitBuy_BOTS    "📊  ETRADE-SPY-LIMITBUY BOTS"    ;;
        7)  menu_kill_all ;;
        8)  menu_attach ;;
        9)  menu_resources ;;
        10) menu_restart ;;
        11) menu_cheatsheet ;;
        12) _tool_menu "MarketPower" "$SCRIPT_MP"  "⚡  MARKET POWER" ;;
        13) _tool_menu "Simulation"  "$SCRIPT_SIM" "🧪  SIMULATION - REAL DATA" "AutoSelectDB_No" ;;
        0)  echo -e "${CYAN}  Bye!${NC}"; exit 0 ;;
        *)  echo -e "${RED}  Invalid option.${NC}"; sleep 1 ;;
    esac
done
