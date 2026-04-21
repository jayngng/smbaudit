#!/bin/bash

ARG="$1"
BASE="$HOME/.nxc/modules/nxc_spider_plus"

rg -li "$ARG" "$BASE" | while read -r file; do
    ip=$(basename "$file" .json)

    jq -r --arg arg "$ARG" --arg ip "$ip" '
      to_entries[]
      | .key as $share
      | .value
      | to_entries[]
      | select(.key | test($arg; "i"))
      | "\\\\" + $ip + "\\" + $share + "\\" + (.key | gsub("/"; "\\"))
    ' "$file"

done
