echo 'for pkg in $(pm list packages --user 0 -f | sed "s/.*=//"); do
  appops set --user 0 "$pkg" SYSTEM_EXEMPT_FROM_DISMISSIBLE_NOTIFICATIONS allow
done
for pkg in $(pm list packages --user 10 -f | sed "s/.*=//"); do
  appops set --user 10 "$pkg" SYSTEM_EXEMPT_FROM_DISMISSIBLE_NOTIFICATIONS allow
done
' | adb shell
