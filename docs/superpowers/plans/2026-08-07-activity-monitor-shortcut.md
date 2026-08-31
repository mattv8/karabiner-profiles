# Activity Monitor Shortcut Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Make global `ctrl+shift+escape` open or focus Activity Monitor.

**Architecture:** Add one unconditional Karabiner complex-modification rule to the live `Windows Mode` profile. The rule consumes exact `control+shift+escape` input and invokes macOS Launch Services with `open -a "Activity Monitor"`; existing backup workflows then copy the validated live file to the repository and Downloads backup.

**Tech Stack:** Karabiner-Elements JSON, `karabiner_cli`, `jq`, Python 3 assertions, macOS `open`

## Global Constraints

- The shortcut must work from every application, including terminal applications.
- Additional modifiers must prevent the shortcut from matching.
- The shell command must be `open -a "Activity Monitor"`.
- Do not alter unrelated Karabiner rules.
- Do not create a Git commit unless the user requests one.

---

### Task 1: Add And Activate The Global Shortcut

**Files:**
- Modify: `/Users/elfy/.config/karabiner/karabiner.json`
- Update: `/Users/elfy/GitRepos/karabiner-windows-shortcuts-profile/karabiner.json`
- Update: `/Users/elfy/Downloads/karabiner-windows-shortcuts-profile/karabiner.json`

**Interfaces:**
- Consumes: Karabiner's `from`, `to`, and `shell_command` complex-modification schema.
- Produces: One global `Ctrl+Shift+Esc opens Activity Monitor` rule in all three configuration copies.

- [ ] **Step 1: Run a failing assertion for the missing shortcut**

```bash
python3 - <<'PY'
import json
from pathlib import Path

path = Path('/Users/elfy/.config/karabiner/karabiner.json')
rules = json.loads(path.read_text())['profiles'][0]['complex_modifications']['rules']

for rule in rules:
    if rule.get('description') != 'Ctrl+Shift+Esc opens Activity Monitor':
        continue
    for manipulator in rule.get('manipulators', []):
        source = manipulator.get('from', {})
        if (
            source == {
                'key_code': 'escape',
                'modifiers': {'mandatory': ['control', 'shift']},
            }
            and manipulator.get('to') == [
                {'shell_command': 'open -a "Activity Monitor"'}
            ]
            and 'conditions' not in manipulator
        ):
            raise SystemExit(0)

raise AssertionError('missing global ctrl+shift+escape Activity Monitor shortcut')
PY
```

Expected: FAIL with `missing global ctrl+shift+escape Activity Monitor shortcut`.

- [ ] **Step 2: Add the minimal global Karabiner rule**

Add this object to `profiles[0].complex_modifications.rules` without changing existing rules:

```json
{
  "description": "Ctrl+Shift+Esc opens Activity Monitor",
  "manipulators": [
    {
      "from": {
        "key_code": "escape",
        "modifiers": {
          "mandatory": ["control", "shift"]
        }
      },
      "to": [
        {
          "shell_command": "open -a \"Activity Monitor\""
        }
      ],
      "type": "basic"
    }
  ]
}
```

- [ ] **Step 3: Run the assertion again**

Run the command from Step 1.

Expected: exit code `0` with no assertion error.

- [ ] **Step 4: Validate the live configuration**

```bash
jq empty "/Users/elfy/.config/karabiner/karabiner.json"
"/Library/Application Support/org.pqrs/Karabiner-Elements/bin/karabiner_cli" \
  --lint-complex-modifications "/Users/elfy/.config/karabiner/karabiner.json"
```

Expected: `jq` exits `0`; Karabiner reports the file as `ok`.

- [ ] **Step 5: Sync and reload the profile**

```bash
cp "/Users/elfy/.config/karabiner/karabiner.json" \
  "/Users/elfy/GitRepos/karabiner-windows-shortcuts-profile/karabiner.json"
cp "/Users/elfy/.config/karabiner/karabiner.json" \
  "/Users/elfy/Downloads/karabiner-windows-shortcuts-profile/karabiner.json"
"/Library/Application Support/org.pqrs/Karabiner-Elements/bin/karabiner_cli" \
  --select-profile "Windows Mode"
"/Library/Application Support/org.pqrs/Karabiner-Elements/bin/karabiner_cli" \
  --show-current-profile-name
```

Expected: the final command prints `Windows Mode`.

- [ ] **Step 6: Confirm all configuration copies match**

```bash
cmp "/Users/elfy/.config/karabiner/karabiner.json" \
  "/Users/elfy/GitRepos/karabiner-windows-shortcuts-profile/karabiner.json"
cmp "/Users/elfy/.config/karabiner/karabiner.json" \
  "/Users/elfy/Downloads/karabiner-windows-shortcuts-profile/karabiner.json"
```

Expected: both commands exit `0` with no output.
