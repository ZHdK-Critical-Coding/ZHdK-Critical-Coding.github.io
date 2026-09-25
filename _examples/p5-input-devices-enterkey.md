---
title: Enter Key
category: input
technology: P5.js
author: Urs Hofer
date: 2026-09-16
repo: P5_Input_Devices_EnterKey
repo_url: https://github.com/ZHdK-Critical-Coding/P5_Input_Devices_EnterKey
related: []
render_with_liquid: false
---

# P5.js: Enter Key

A p5.js sketch that shows three ways to react to the **Enter** key: while it
is held down, as a one-shot action on press, and as an on/off toggle. Each
state is shown as a filled circle.

## How to Use

1. Start Live Server (click **Go Live** in the VS Code status bar).
2. Click the canvas so it has keyboard focus.
3. Press and release **Enter**:
   - **Down** (red): filled as long as the key is held.
   - **Once** (green): lights up for one second on each press.
   - **Toggled** (blue): switches on or off each time the key is released.

## How it Works

`keyPressed()` sets `isDown` only if the key was not already down, so the
key-repeat of a held key does not trigger the one-shot action again.
`doOnceOnPress()` ignores further calls until its 1-second `setTimeout`
has reset the flag. `keyReleased()` clears `isDown` and flips `isToggled`.
Both handlers return `false` to suppress the browser's default key behaviour.

## Libraries

- p5.js 1.10.0
- p5.sound 1.0.1 (included, not used)
