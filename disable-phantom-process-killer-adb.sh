echo 'device_config set_sync_disabled_for_tests persistent
device_config put activity_manager max_phantom_processes 2147483647
settings put global settings_enable_monitor_phantom_procs false
' | adb shell
