# gourneau/homebrew-tap

Homebrew casks for my Mac apps.

```bash
brew tap gourneau/tap
brew install --cask aurora-glass
```

## Casks

| | |
|---|---|
| [`aurora-glass`](Casks/aurora-glass.rb) | [Aurora Glass](https://aurora.radiantmachines.com) — a live GPU fluid simulation painted across the menu bar |

Installing Aurora Glass through this cask also puts its `aurora` command on
your `PATH`. The command ships inside the app bundle, so a plain disk-image
install leaves it present but not runnable by name.

```bash
aurora busy
pytest && aurora ok || aurora fail
```
