# Activity Monitor Shortcut Design

## Goal

Make `ctrl+shift+escape` open Activity Monitor from any application, including terminal applications.

## Design

Add one global Karabiner complex-modification rule named `Ctrl+Shift+Esc opens Activity Monitor`.

The manipulator will:

- Match `escape` with mandatory `control` and `shift` modifiers.
- Reject combinations containing additional modifiers.
- Run `open -a "Activity Monitor"`.
- Open Activity Monitor when closed and focus its existing instance when open.

The rule will not include application conditions because the shortcut must work everywhere.

## Verification

1. Assert that the live JSON contains the exact input and shell command.
2. Validate JSON syntax with `jq empty`.
3. Lint the complex modifications with `karabiner_cli --lint-complex-modifications`.
4. Sync the live configuration to the Git repository and Downloads backup.
5. Reload `Windows Mode` and confirm it remains the active profile.
