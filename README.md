# Karabiner Windows Shortcuts Profile

Lightweight Karabiner profile for making macOS keyboard shortcuts behave more like Windows while preserving raw `Ctrl` behavior in terminal apps.

## Included behavior

- Global Windows-style editing shortcuts in normal GUI apps
  - `Ctrl+A/C/V/X/Z/Y/F/N/O/P/S/T/W/R`
- Browser-specific shortcuts
  - `Home` -> beginning of text field
  - `End` -> end of text field
  - `Ctrl+L`
  - `Ctrl+H`
  - `Ctrl+Tab`
  - `Ctrl+Shift+Tab`
- Finder selection shortcuts
  - `Ctrl+Click` -> multi-select item
  - `Ctrl+Shift+Click` -> select range between items
- Terminal passthrough for raw control sequences
  - `Ctrl+C`
  - `Ctrl+L`
  - `Ctrl+R`
- Terminal-specific behavior
  - real `iTerm.app`: `Ctrl+T` vertical split, `Ctrl+Shift+T` horizontal split
  - `Terminal.app`: `Ctrl+T` new tab, `Cmd+T` passes through to the app's current `Ctrl+T` binding for `New Command...`
- Terminal `Home` / `End`
  - `Home` -> beginning of line
  - `End` -> end of line
- Terminal word movement
  - `Ctrl+Left` -> move one word left
  - `Ctrl+Right` -> move one word right
- System shortcuts
  - `Print Screen` opens the macOS screenshot tool
  - `Ctrl+Shift+Esc` opens Activity Monitor
  - `Cmd+.` opens the emoji picker

## Files

- `karabiner.json`: active Karabiner configuration

## Install

1. Install Karabiner-Elements.
2. Back up your existing config if needed:

```sh
cp ~/.config/karabiner/karabiner.json ~/.config/karabiner/karabiner.json.backup
```

3. Copy this config into place:

```sh
mkdir -p ~/.config/karabiner
cp karabiner.json ~/.config/karabiner/karabiner.json
```

4. Open Karabiner-Elements and ensure the `Windows Mode` profile is selected.

## Notes

- This setup is Karabiner-only. It does not require `hidutil`.
- If you previously installed the old `hidutil` daemon, remove it separately.
- Terminal apps are intentionally excluded from most global `Ctrl -> Cmd` rewrites so shell shortcuts keep working.
- `Cmd+Arrow` tiling is no longer handled here if you use Rectangle or another window manager.
- `Terminal.app` menu shortcuts can vary if you have customized them in Terminal settings.
