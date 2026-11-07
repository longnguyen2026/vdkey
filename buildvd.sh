#!/usr/bin/env bash
# ==============================================================================
# Script cài đặt môi trường build & thư viện phát triển cho dự án VDKey
# Hỗ trợ: Ubuntu / Debian / Linux Mint (20.x, 21.x, 22.x)
# ==============================================================================
set -e

if [ "$EUID" -eq 0 ]; then
    SUDO=""
else
    SUDO="sudo"
fi

echo "=== [1/5] Cập nhật danh sách gói hệ thống ==="
$SUDO apt-get update -y

echo "=== [2/5] Cài đặt công cụ biên dịch (Core Build Tools) ==="
$SUDO apt-get install -y \
    build-essential \
    cmake \
    ninja-build \
    extra-cmake-modules \
    pkg-config \
    gettext \
    librsvg2-bin \
    libfmt-dev \
    git \
    curl

echo "=== [3/5] Cài đặt các thư viện phát triển Fcitx5 (Fcitx5 Dev Headers) ==="
$SUDO apt-get install -y \
    libfcitx5core-dev \
    libfcitx5config-dev \
    libfcitx5utils-dev \
    fcitx5-modules-dev \
    fcitx5-module-dbus \
    fcitx5-module-emoji \
    fcitx5-module-quickphrase-editor

echo "=== [4/5] Cài đặt môi trường Python & phụ thuộc GUI (Qt6 / GTK) ==="
$SUDO apt-get install -y \
    python3 \
    python3-dev \
    python3-pip \
    python3-pil \
    python3-pyqt6 \
    python3-pyqt5 \
    python3-gi \
    gir1.2-gtk-3.0

echo "=== [5/5] Kiểm tra và cài đặt Rust Toolchain (yêu cầu cho bamboo-rs) ==="
if ! command -v cargo >/dev/null 2>&1; then
    echo "-> Đang cài đặt Rust/Cargo qua rustup..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source "$HOME/.cargo/env"
else
    echo "-> Đã tìm thấy Rust/Cargo: $(cargo --version)"
fi

echo ""
echo "=================================================================="
echo ">> HOÀN TẤT CÀI ĐẶT THƯ VIỆN & MÔI TRƯỜNG BUILD CHO VDKEY!"
echo "=================================================================="
