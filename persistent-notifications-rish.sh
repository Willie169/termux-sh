#!/usr/bin/env bash

# shellcheck disable=2016
echo 'while IFS= read -r line; do
    for pkg in $(pm list packages --user "$line" -f | sed "s/.*=//"); do
      appops set --user "$line" "$pkg" SYSTEM_EXEMPT_FROM_DISMISSIBLE_NOTIFICATIONS allow
    done
done <<EOF
$(pm list users | tail -n+2 | sed '"'"'s/^.*UserInfo{//; s/:.*}.*$//'"'"')
EOF
' | rish
