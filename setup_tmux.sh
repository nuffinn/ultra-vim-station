#!/bin/bash

# setup_tmux.sh
# Tmux setup for macOS and Arch Linux
# Uses Oh my tmux! (https://github.com/gpakosz/.tmux) as base configuration

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TMUX_SOURCE_DIR="$SCRIPT_DIR/tmux"
TMUX_CONFIG_DIR="$HOME/.config/tmux"

echo "Setting up tmux..."

# Detect OS (expects OS variable from parent script, or detect locally)
if [ -z "$OS" ]; then
    if [[ "$OSTYPE" == "darwin"* ]]; then
        OS="macos"
    elif [[ -f /etc/arch-release ]]; then
        OS="arch"
    else
        OS="unknown"
    fi
fi

# Install tmux and dependencies
install_tmux_macos() {
    echo "Installing tmux for macOS..."

    # tmux should be installed via brew
    if ! command -v tmux &> /dev/null; then
        brew install tmux
    else
        echo "  tmux is already installed."
    fi

    # Install reattach-to-user-namespace for clipboard support (optional but recommended)
    if ! brew list reattach-to-user-namespace &> /dev/null; then
        echo "  Installing reattach-to-user-namespace for clipboard support..."
        brew install reattach-to-user-namespace
    fi
}

install_tmux_arch() {
    echo "Installing tmux for Arch Linux..."

    # tmux and clipboard utilities
    sudo pacman -S --noconfirm --needed tmux

    # Install clipboard utilities for X11/Wayland support
    echo "  Installing clipboard utilities..."
    sudo pacman -S --noconfirm --needed xsel xclip wl-clipboard
}

# Link configuration
link_tmux_config() {
    echo "Linking tmux configuration..."

    if [ -L "$TMUX_CONFIG_DIR" ]; then
        CURRENT_LINK=$(readlink "$TMUX_CONFIG_DIR")
        if [ "$CURRENT_LINK" == "$TMUX_SOURCE_DIR" ]; then
            echo "  Tmux configuration already linked correctly."
            return 0
        else
            echo "  Warning: $TMUX_CONFIG_DIR is linked to $CURRENT_LINK."
            echo "  Removing existing symlink..."
            rm "$TMUX_CONFIG_DIR"
        fi
    elif [ -d "$TMUX_CONFIG_DIR" ]; then
        echo "  Backing up existing tmux config to $TMUX_CONFIG_DIR.bak"
        mv "$TMUX_CONFIG_DIR" "$TMUX_CONFIG_DIR.bak"
    fi

    # Create parent directory if needed
    mkdir -p "$(dirname "$TMUX_CONFIG_DIR")"

    # Create symlink
    ln -s "$TMUX_SOURCE_DIR" "$TMUX_CONFIG_DIR"
    echo "  Linked $TMUX_SOURCE_DIR to $TMUX_CONFIG_DIR"
}

# Adjust shell path in config for different OS
adjust_shell_path() {
    local local_conf="$TMUX_SOURCE_DIR/tmux.conf.local"

    if [[ "$OS" == "macos" ]]; then
        # Check if zsh path needs to be updated for macOS
        if grep -q "default-shell /usr/bin/zsh" "$local_conf"; then
            echo "  Adjusting default shell path for macOS..."
            # macOS zsh is at /bin/zsh
            sed -i.bak 's|default-shell /usr/bin/zsh|default-shell /bin/zsh|g' "$local_conf"
            rm -f "$local_conf.bak"
        fi
    elif [[ "$OS" == "arch" ]]; then
        # Ensure Linux path for zsh
        if grep -q "default-shell /bin/zsh" "$local_conf"; then
            echo "  Adjusting default shell path for Arch Linux..."
            sed -i 's|default-shell /bin/zsh|default-shell /usr/bin/zsh|g' "$local_conf"
        fi
    fi
}

# Main setup function
setup_tmux() {
    # Install tmux based on OS
    if [[ "$OS" == "macos" ]]; then
        install_tmux_macos
    elif [[ "$OS" == "arch" ]]; then
        install_tmux_arch
    else
        echo "Error: Unsupported OS for tmux setup"
        return 1
    fi

    # Link configuration
    link_tmux_config

    # Adjust paths for current OS
    adjust_shell_path

    echo "Tmux setup complete!"
    echo ""
    echo "Tmux key bindings (Oh my tmux!):"
    echo "  Prefix: Ctrl+s (instead of default Ctrl+b)"
    echo "  Reload config: <prefix> + r"
    echo "  Pane navigation: <prefix> + h/j/k/l"
    echo "  Split horizontal: <prefix> + -"
    echo "  Split vertical: <prefix> + _"
    echo "  Zoom pane: Ctrl+z"
}

# Run setup if called directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    setup_tmux
fi
