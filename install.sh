#!/bin/bash

set -euo pipefail

DOTFILES_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

GO_VERSION='1.27.3'
NODE_MAJOR='24'
RG_VERSION='15.2.0'
FD_VERSION='10.5.0'
FZF_VERSION='0.74.5'
TMUX_VERSION='3.5a'
LAZYGIT_VERSION='0.66.2'
NVIM_VERSION='0.11.7'
TREE_SITTER_VERSION='0.25.10'

BASE_PACKAGES=(
    curl
    zathura
    yakuake
    gh
    qt5-style-kvantum
    gcc
    python3-venv
    xclip
    software-properties-common
)

TMUX_BUILD_PACKAGES=(
    libevent-dev
    ncurses-dev
    build-essential
    bison
    pkg-config
)

CHECK_ONLY=0

usage() {
    printf 'Usage: %s [--check]\n' "$(basename "$0")"
    printf '  --check   Report installed/missing items without changing anything\n'
}

while (( $# )); do
    case "$1" in
        --check) CHECK_ONLY=1 ;;
        -h|--help) usage; exit 0 ;;
        *) printf 'Unknown argument: %s\n' "$1" >&2; usage >&2; exit 2 ;;
    esac
    shift
done

log() { printf '%s\n' "$*"; }
installed() { log "Already installed: $*"; }
missing() { log "Missing: $*"; }
has_cmd() { command -v "$1" >/dev/null 2>&1; }

load_nvm() {
    export NVM_DIR="${NVM_DIR:-$HOME/.nvm}"
    if [ -s "${NVM_DIR}/nvm.sh" ]; then
        \. "${NVM_DIR}/nvm.sh"
    fi
}

apt_install() {
    local pkg missing_pkgs=()
    for pkg in "$@"; do
        if ! dpkg-query -W -f='${Status}' "$pkg" 2>/dev/null | grep -q "install ok installed"; then
            missing_pkgs+=("$pkg")
        fi
    done
    if (( ${#missing_pkgs[@]} == 0 )); then
        installed "$*"
        return 0
    fi
    if (( CHECK_ONLY )); then
        missing "${missing_pkgs[*]}"
        return 0
    fi
    sudo apt-get install -y "${missing_pkgs[@]}"
}

install_base_packages() {
    apt_install "${BASE_PACKAGES[@]}"
}

install_node() {
    load_nvm
    if has_cmd node; then
        installed "node $(node -v)"
    else
        if (( CHECK_ONLY )); then
            missing "node ${NODE_MAJOR}"
            return 0
        fi
        if [ ! -s "${NVM_DIR}/nvm.sh" ]; then
            curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
            load_nvm
        fi
        nvm install "${NODE_MAJOR}"
    fi
    if (( ! CHECK_ONLY )); then
        corepack enable pnpm
        pnpm -v >/dev/null
    fi
}

install_go() {
    local file="go${GO_VERSION}.linux-amd64.tar.gz"
    if [ -x /usr/local/go/bin/go ]; then
        installed "go ${GO_VERSION}"
        return 0
    fi
    if (( CHECK_ONLY )); then
        missing "go ${GO_VERSION}"
        return 0
    fi
    log "Installing go ${GO_VERSION}..."
    curl -fL -o "${DOTFILES_DIR}/${file}" "https://go.dev/dl/${file}"
    rm -rf "${DOTFILES_DIR}/go"
    tar xzf "${DOTFILES_DIR}/${file}" -C "${DOTFILES_DIR}"
    sudo rm -rf /usr/local/go
    sudo mv "${DOTFILES_DIR}/go" /usr/local/
    rm -f "${DOTFILES_DIR}/${file}"
}

install_ripgrep() {
    local file="ripgrep-${RG_VERSION}-x86_64-unknown-linux-musl"
    if has_cmd rg; then
        installed "ripgrep ${RG_VERSION}"
        return 0
    fi
    if (( CHECK_ONLY )); then
        missing "ripgrep ${RG_VERSION}"
        return 0
    fi
    log "Installing ripgrep ${RG_VERSION}..."
    curl -fL -o "${DOTFILES_DIR}/${file}.tar.gz" "https://github.com/BurntSushi/ripgrep/releases/download/${RG_VERSION}/${file}.tar.gz"
    rm -rf "${DOTFILES_DIR:?}/${file}"
    tar xzf "${DOTFILES_DIR}/${file}.tar.gz" -C "${DOTFILES_DIR}"
    sudo install -Dm755 "${DOTFILES_DIR}/${file}/rg" /usr/local/bin/rg
    sudo install -Dm644 "${DOTFILES_DIR}/${file}/doc/rg.1" /usr/local/man/man1/rg.1
    rm -rf "${DOTFILES_DIR:?}/${file}"*
}

install_fd() {
    local file="fd-v${FD_VERSION}-x86_64-unknown-linux-musl"
    if has_cmd fd; then
        installed "fd ${FD_VERSION}"
        return 0
    fi
    if (( CHECK_ONLY )); then
        missing "fd ${FD_VERSION}"
        return 0
    fi
    log "Installing fd ${FD_VERSION}..."
    curl -fL -o "${DOTFILES_DIR}/${file}.tar.gz" "https://github.com/sharkdp/fd/releases/download/v${FD_VERSION}/${file}.tar.gz"
    rm -rf "${DOTFILES_DIR:?}/${file}"
    tar xzf "${DOTFILES_DIR}/${file}.tar.gz" -C "${DOTFILES_DIR}"
    sudo install -Dm755 "${DOTFILES_DIR}/${file}/fd" /usr/local/bin/fd
    sudo install -Dm644 "${DOTFILES_DIR}/${file}/fd.1" /usr/local/man/man1/fd.1
    rm -rf "${DOTFILES_DIR:?}/${file}"*
}

install_fzf() {
    local file="fzf-${FZF_VERSION}-linux_amd64"
    if has_cmd fzf; then
        installed "fzf ${FZF_VERSION}"
        return 0
    fi
    if (( CHECK_ONLY )); then
        missing "fzf ${FZF_VERSION}"
        return 0
    fi
    log "Installing fzf ${FZF_VERSION}..."
    curl -fL -o "${DOTFILES_DIR}/${file}.tar.gz" "https://github.com/junegunn/fzf/releases/download/v${FZF_VERSION}/${file}.tar.gz"
    rm -f "${DOTFILES_DIR}/fzf"
    tar xzf "${DOTFILES_DIR}/${file}.tar.gz" -C "${DOTFILES_DIR}"
    sudo install -Dm755 "${DOTFILES_DIR}/fzf" /usr/local/bin/fzf
    rm -rf "${DOTFILES_DIR:?}/${file}"*
}

install_tmux() {
    local file="tmux-${TMUX_VERSION}"
    if has_cmd tmux; then
        installed "tmux ${TMUX_VERSION}"
        return 0
    fi
    if (( CHECK_ONLY )); then
        missing "tmux ${TMUX_VERSION}"
        return 0
    fi
    log "Installing tmux ${TMUX_VERSION}..."
    apt_install "${TMUX_BUILD_PACKAGES[@]}"
    curl -fL -o "${DOTFILES_DIR}/${file}.tar.gz" "https://github.com/tmux/tmux/releases/download/${TMUX_VERSION}/${file}.tar.gz"
    rm -rf "${DOTFILES_DIR:?}/${file}"
    tar xzf "${DOTFILES_DIR}/${file}.tar.gz" -C "${DOTFILES_DIR}"
    ( cd "${DOTFILES_DIR}/${file}" && sh ./configure && make && sudo make install )
    rm -rf "${DOTFILES_DIR:?}/${file}"*
}

install_lazygit() {
    local file="lazygit_${LAZYGIT_VERSION}_Linux_x86_64"
    if has_cmd lazygit; then
        installed "lazygit ${LAZYGIT_VERSION}"
        return 0
    fi
    if (( CHECK_ONLY )); then
        missing "lazygit ${LAZYGIT_VERSION}"
        return 0
    fi
    log "Installing lazygit ${LAZYGIT_VERSION}..."
    curl -fL -o "${DOTFILES_DIR}/${file}.tar.gz" "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/${file}.tar.gz"
    rm -f "${DOTFILES_DIR}/lazygit"
    tar xzf "${DOTFILES_DIR}/${file}.tar.gz" --exclude=LICENSE --exclude=README.md -C "${DOTFILES_DIR}"
    sudo install -Dm755 "${DOTFILES_DIR}/lazygit" /usr/local/bin/lazygit
    rm -rf "${DOTFILES_DIR:?}/${file}"*
}

install_neovim() {
    local file='nvim-linux-x86_64'
    if has_cmd nvim; then
        installed "neovim ${NVIM_VERSION}"
        return 0
    fi
    if (( CHECK_ONLY )); then
        missing "neovim ${NVIM_VERSION}"
        return 0
    fi
    log "Installing neovim ${NVIM_VERSION}..."
    curl -fL -o "${DOTFILES_DIR}/${file}.tar.gz" "https://github.com/neovim/neovim/releases/download/v${NVIM_VERSION}/${file}.tar.gz"
    rm -rf "${DOTFILES_DIR:?}/${file}"
    tar xzf "${DOTFILES_DIR}/${file}.tar.gz" -C "${DOTFILES_DIR}"
    sudo cp -rf "${DOTFILES_DIR}/${file}/bin/"* /usr/local/bin/
    sudo cp -rf "${DOTFILES_DIR}/${file}/lib/"* /usr/local/lib/
    sudo cp -rf "${DOTFILES_DIR}/${file}/share/"* /usr/local/share/
    rm -rf "${DOTFILES_DIR:?}/${file}"*
}

install_tree_sitter() {
    if has_cmd tree-sitter; then
        installed "tree-sitter-cli ${TREE_SITTER_VERSION}"
        return 0
    fi
    if (( CHECK_ONLY )); then
        missing "tree-sitter-cli ${TREE_SITTER_VERSION}"
        return 0
    fi
    load_nvm
    npm i -g "tree-sitter-cli@${TREE_SITTER_VERSION}"
}

install_firefox() {
    local pin_file='/etc/apt/preferences.d/mozilla-firefox'
    if dpkg-query -W -f='${Status}' firefox 2>/dev/null | grep -q "install ok installed" && [ -f "${pin_file}" ]; then
        installed "firefox"
        return 0
    fi
    if (( CHECK_ONLY )); then
        missing "firefox"
        return 0
    fi
    log "Installing Firefox..."
    sudo add-apt-repository -y ppa:mozillateam/ppa
    sudo apt-get update
    sudo tee "${pin_file}" >/dev/null <<'EOF'
Package: *
Pin: release o=LP-PPA-mozillateam
Pin-Priority: 1001

Package: firefox
Pin: version 1:1snap*
Pin-Priority: -1
EOF
    apt_install firefox
    echo 'Unattended-Upgrade::Allowed-Origins:: "LP-PPA-mozillateam:${distro_codename}";' | sudo tee /etc/apt/apt.conf.d/51unattended-upgrades-firefox >/dev/null
}

install_docker() {
    if has_cmd docker; then
        installed "docker ($(docker --version))"
    else
        if (( CHECK_ONLY )); then
            missing "docker"
        else
            log "Installing docker..."
            curl -fsSL https://get.docker.com -o /tmp/install-docker.sh
            sudo sh /tmp/install-docker.sh
            rm -f /tmp/install-docker.sh
        fi
    fi
    apt_install uidmap
    if [ -f "${HOME}/.config/systemd/user/docker.service" ]; then
        installed "docker rootless"
    else
        if (( CHECK_ONLY )); then
            missing "docker rootless setup"
        else
            log "Configuring docker to run in rootless mode..."
            dockerd-rootless-setuptool.sh install
        fi
    fi
}

install_opencode() {
    if has_cmd opencode || [ -x "${HOME}/.opencode/bin/opencode" ]; then
        installed "opencode"
        return 0
    fi
    if (( CHECK_ONLY )); then
        missing "opencode"
        return 0
    fi
    log "Installing opencode..."
    curl -fsSL https://opencode.ai/install | bash
}

if (( CHECK_ONLY )); then
    log "Checking software (no changes will be made)..."
else
    log "Updating package lists..."
    sudo apt-get update
fi

install_base_packages
install_node
install_go
install_ripgrep
install_fd
install_fzf
install_tmux
install_lazygit
install_neovim
install_tree_sitter
install_firefox
install_docker
install_opencode

if (( CHECK_ONLY )); then
    log "Check complete."
else
    log "All software installed."
fi
