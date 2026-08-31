# Karabiner Windows Shortcuts Profile

Personal Karabiner-Elements profile for macOS. It keeps Windows-style shortcuts, terminal passthroughs, Logitech G950 mappings, and media-key behavior in one restorable file.

## Restore On A New Mac

Install Karabiner-Elements first, then run:

```sh
git clone <repo-url> ~/GitRepos/karabiner-windows-shortcuts-profile
cd ~/GitRepos/karabiner-windows-shortcuts-profile
./restore.sh
```

If this repo already exists locally:

```sh
cd ~/GitRepos/karabiner-windows-shortcuts-profile
git pull
./restore.sh
```

Karabiner usually reloads `~/.config/karabiner/karabiner.json` on its own. If it does not, quit and reopen Karabiner-Elements.

## Save Current Karabiner Changes

After editing rules in Karabiner-Elements, copy the live profile back into this repo:

```sh
cd ~/GitRepos/karabiner-windows-shortcuts-profile
./update-from-system.sh
git diff
```

Commit after you review the diff:

```sh
git add karabiner.json README.md restore.sh update-from-system.sh
git commit -m "Update Karabiner profile"
```

## Included Rules

- `alt+.` opens the macOS emoji picker.
- Play/Pause media key opens Spotify if it is closed, or toggles playback if it is open.
- iTerm `ctrl+t` opens a pane to the right.
- iTerm `ctrl+shift+t` opens a pane below.
- Windows-style browser shortcuts map to macOS browser shortcuts.
- Windows-style edit and navigation shortcuts work outside terminal apps.
- Terminal apps keep important `ctrl` shortcuts for shells, nano, and readline.
- Logitech G950 keypad and Spotlight mappings are included.
- Finder click selection shortcuts are included.

## Files

- `karabiner.json`: source of truth for the profile.
- `restore.sh`: copies this repo's profile into Karabiner's config directory.
- `update-from-system.sh`: copies the live Karabiner config into this repo.

## Safety Check

Validate the JSON before restoring:

```sh
jq empty karabiner.json
```

`restore.sh` runs this check before it writes to `~/.config/karabiner/karabiner.json`.
