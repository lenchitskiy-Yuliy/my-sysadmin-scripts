#!/usr/bin/env bash

set -u

readonly INTERVAL=10
readonly OUTPUT_FILE="monitor.log"

check_command() {
    if ! command -v "$1" >/dev/null 2>&1; then
        echo "Ошибка: команда '$1' не найдена." >&2
        exit 1
    fi
}

collect_metrics() {
    {
        echo "--- $(date '+%Y-%m-%d %H:%M:%S') ---"
        free -h
        df -h
        uptime
        echo
    } >> "$OUTPUT_FILE"
}

check_command free
check_command df
check_command uptime

while true; do
    collect_metrics
    sleep "$INTERVAL"
done
