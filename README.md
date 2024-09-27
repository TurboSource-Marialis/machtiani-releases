
# Machtiani Installation Script

This script is designed to work on both **macOS** and **Linux** to automatically install the `machtiani` tool. It detects the operating system and architecture, downloads the correct binary from GitHub Releases, and installs it in the user’s `~/.local/bin` directory.

## Supported Platforms
- **macOS** (Intel and Apple Silicon)
- **Linux** (x86_64)

## What the Script Does
1. Detects whether the operating system is macOS or Linux.
2. Downloads the correct binary from GitHub Releases based on the detected OS and architecture.
3. Installs the binary into the `$HOME/.local/bin` directory (no `sudo` required).
4. Adds the directory to your `PATH` if it's not already included.
5. Makes the binary executable so it can be run directly from the terminal.

## Installation Instructions

You can use either `curl` or `wget` to download and run the script in a single command:

### Using `curl`
```bash
curl -L https://raw.githubusercontent.com/turbosource-marialis/machtiani-releases/main/install.sh | bash

```

### Using `wget`
```bash
wget -O - https://raw.githubusercontent.com/turbosource-marialis/machtiani-releases/main/install.sh | bash

```

### Post-Installation

- The binary will be installed in `~/.local/bin/machtiani`.
- If `~/.local/bin` is not in your `PATH`, the script will offer to automatically add it to your `.bashrc` or `.zshrc`. Alternatively, you can manually add it by appending this line to your shell configuration file:
  ```bash
  export PATH=\$PATH:$HOME/.local/bin
  ```
  After making the change, either restart your terminal or run:
  ```bash
  source ~/.bashrc  # for bash
  source ~/.zshrc   # for zsh
  ```

### Uninstall
To remove the `machtiani` tool, simply delete the binary:
```bash
rm ~/.local/bin/machtiani
```
