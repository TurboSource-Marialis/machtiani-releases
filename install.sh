#!/bin/bash

# Set the URL of the latest release (replace with your own repo URL)
REPO="https://github.com/TurboSource-Marialis/machtiani-releases/releases/download/pre-release-9995650"
MACOS_AMD64="machtiani-darwin-amd64"
MACOS_ARM64="machtiani-darwin-arm64"
LINUX_AMD64="machtiani-linux-amd64"

# Determine the OS and architecture
OS=$(uname -s)
ARCH=$(uname -m)

# Determine the correct binary to download
if [[ "$OS" == "Darwin" ]]; then
    if [[ "$ARCH" == "x86_64" ]]; then
        BINARY=$MACOS_AMD64
    elif [[ "$ARCH" == "arm64" ]]; then
        BINARY=$MACOS_ARM64
    else
        echo "Unsupported macOS architecture: $ARCH"
        exit 1
    fi
elif [[ "$OS" == "Linux" ]]; then
    if [[ "$ARCH" == "x86_64" ]]; then
        BINARY=$LINUX_AMD64
    else
        echo "Unsupported Linux architecture: $ARCH"
        exit 1
    fi
else
    echo "Unsupported OS: $OS"
    exit 1
fi

# Install path (user directory, doesn't require sudo)
INSTALL_DIR="$HOME/.local/bin"

# Create the install directory if it doesn't exist
mkdir -p "$INSTALL_DIR"

# Download the binary
echo "Downloading $BINARY to $INSTALL_DIR..."
curl -L "$REPO/$BINARY" -o "$INSTALL_DIR/machtiani"

# Make the binary executable
chmod +x "$INSTALL_DIR/machtiani"

# Create the configuration file
CONFIG_FILE="$HOME/.machtiani-config.yml"

# Check if the configuration file already exists
if [[ -f "$CONFIG_FILE" ]]; then
    echo "Configuration file already exists at $CONFIG_FILE."
    echo "If you want to overwrite it, please delete it first or choose a different name."
else
    cat <<EOL > "$CONFIG_FILE"
environment:
  API_GATEWAY_HOST_VALUE: "" # Your machtiani RapidAPI Key
  MODEL_API_KEY: "" # Your OpenAPI Key
  CODE_HOST_API_KEY: "" # Your Github API Key (optional; if using ensure it has repo scopes)

  # DEFAULTS: DON'T CHANGE THE BELOW UNLESS YOU HAVE REASON
  MACHTIANI_URL: "https://machtiani2.p.rapidapi.com"
  MACHTIANI_REPO_MANAGER_URL: "https://machtiani2.p.rapidapi.com"
  CONTENT_TYPE_KEY: "Content-Type"
  CONTENT_TYPE_VALUE: "application/json"
  API_GATEWAY_HOST_KEY: "X-RapidAPI-Key"
EOL

    echo "Configuration file created at $CONFIG_FILE"
fi

# Check if INSTALL_DIR is in the user's PATH
if [[ ":$PATH:" == *":$INSTALL_DIR:"* ]]; then
    echo "$INSTALL_DIR is already in your PATH."
else
    echo "$INSTALL_DIR is not in your PATH."

    # Notify the user and provide options
    echo "To use 'machtiani' globally, it needs to be added to your PATH."
    echo "This can be done by adding the following line to your .bashrc or .zshrc:"
    echo ""
    echo "    export PATH=\$PATH:$INSTALL_DIR"
    echo ""

    # Ask the user if they want the script to do it automatically
    read -p "Would you like to automatically add this line to both .bashrc and .zshrc? (y/n): " response
    if [[ "$response" == "y" ]]; then
        echo "Adding export line to .bashrc and .zshrc..."
        echo "export PATH=\$PATH:$INSTALL_DIR" >> "$HOME/.bashrc"
        echo "export PATH=\$PATH:$INSTALL_DIR" >> "$HOME/.zshrc"
        echo "Added. Please restart your terminal or run 'source ~/.bashrc' or 'source ~/.zshrc' to apply the changes."
    else
        echo "Please manually add the line to your shell configuration files."
    fi
fi

# Verify installation
if command -v machtiani &> /dev/null; then
    echo "Installation successful! You can now use 'machtiani'."
else
    echo "Installation failed. Please check the installation path and permissions."
    exit 1
fi
