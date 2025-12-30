# Fossibot F106 Pro kernel config notes

Baseline: `real fossibot/defconfig` from the stock image dump.

## Differences vs stock defconfig

- Enabled additional namespace support required for modern Android userspace:
  - `CONFIG_USER_NS=y`
  - `CONFIG_PID_NS=y`
  - `CONFIG_IPC_NS=y`

All other options in `arch/arm64/configs/fossibot_f106pro_defconfig` match the
stock `real fossibot/defconfig`.
