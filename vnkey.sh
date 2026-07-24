#!/usr/bin/env bash
#
# install-vnkey.sh
# Install VnKey (Fcitx5)
# Author: Long Nguyen
#

set -e

URL="https://github.com/marixdev/vnkey/releases/download/v1.0.3/vnkey-fcitx5_1.0.3_amd64.deb"
TMP="/tmp/vnkey-fcitx5.deb"

GREEN="\033[1;32m"
RED="\033[1;31m"
BLUE="\033[1;34m"
NC="\033[0m"

log() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

die() {
    echo -e "${RED}[ERROR]${NC} $1"
    exit 1
}

echo
echo "========================================"
echo "        VnKey Installer"
echo "========================================"
echo

if ! command -v apt >/dev/null; then
    die "This installer only supports Debian/Ubuntu/Linux Mint/Kubuntu."
fi

log "Updating repositories..."
sudo apt update

log "Installing required packages..."
sudo apt install -y \
    wget \
    curl \
    fcitx5 \
    fcitx5-configtool \
    kde-config-fcitx5

log "Downloading VnKey..."
wget -q --show-progress -O "$TMP" "$URL"

if ! dpkg-deb --info "$TMP" >/dev/null 2>&1; then
    die "Downloaded file is not a valid Debian package."
fi

log "Installing VnKey..."
sudo apt install -y "$TMP"

rm -f "$TMP"

echo
echo -e "${BLUE}========================================${NC}"
echo -e "${GREEN}VnKey installed successfully!${NC}"
echo
echo "Next steps:"
echo
echo "1. Logout then login again."
echo
echo "2. System Settings"
echo "   -> Keyboard"
echo "   -> Virtual Keyboard"
echo "   -> Select Fcitx5"
echo
echo "3. Open Fcitx5 Configuration"
echo
echo "4. Add:"
echo "      Vietnamese (VnKey)"
echo
echo "5. Apply"
echo
echo "Default shortcut:"
echo "    Ctrl + Space"
echo
echo -e "${BLUE}========================================${NC}"
