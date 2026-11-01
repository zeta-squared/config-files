#!/bin/bash

set -euo pipefail

DOTFILES_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
HOME_TREE="${DOTFILES_DIR}/home"
if [ ! -d "${HOME_TREE}" ]; then
    HOME_TREE="${DOTFILES_DIR}"
fi

CHECK_ONLY=0

usage() {
    printf 'Usage: %s [--check]\n' "$(basename "$0")"
    printf '  --check   Report configured/missing items without changing anything\n'
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
installed() { log "Already configured: $*"; }
missing() { log "Missing: $*"; }
has_cmd() { command -v "$1" >/dev/null 2>&1; }

is_linked() {
    local src=$1 dest=$2
    [ -L "${dest}" ] && [ "$(readlink -f "${dest}")" = "$(readlink -f "${src}")" ]
}

link_top_level() {
    local name src dest
    for name in .bashrc .tmux.conf .gitconfig; do
        src="${HOME_TREE}/${name}"
        if [ ! -e "${src}" ]; then
            src="${DOTFILES_DIR}/${name}"
        fi
        if [ ! -e "${src}" ]; then
            log "Skipping ${name}: source not found"
            continue
        fi
        dest="${HOME}/${name}"
        if is_linked "${src}" "${dest}"; then
            installed "${name}"
        elif (( CHECK_ONLY )); then
            missing "${name}"
        else
            ln -sfn "${src}" "${dest}"
        fi
    done
}

link_tree() {
    local srcdir=$1 destdir=$2
    local src dest
    if [ ! -d "${srcdir}" ]; then
        return 0
    fi
    if (( ! CHECK_ONLY )); then
        mkdir -p "${destdir}"
    fi
    for src in "${srcdir}"/*; do
        dest="${destdir}/$(basename "${src}")"
        if is_linked "${src}" "${dest}"; then
            installed "$(basename "${src}")"
        elif (( CHECK_ONLY )); then
            missing "$(basename "${src}")"
        else
            ln -sfn "${src}" "${dest}"
        fi
    done
}

configure_dotfiles() {
    link_top_level
    link_tree "${HOME_TREE}/config" "${HOME}/.config"
    if (( ! CHECK_ONLY )); then
        rm -rf "${HOME}/.local/share/konsole"
    fi
    link_tree "${HOME_TREE}/local" "${HOME}/.local/share"
}

configure_neovim() {
    local plug_vim="${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/autoload/plug.vim"
    local venv="${HOME}/.local/share/nvim/nvim_venv"

    if [ -f "${plug_vim}" ]; then
        installed "vim-plug"
    elif (( CHECK_ONLY )); then
        missing "vim-plug"
    else
        curl -fsSLo "${plug_vim}" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    fi

    if [ -x "${venv}/bin/python" ]; then
        installed "nvim python venv"
    elif (( CHECK_ONLY )); then
        missing "nvim python venv"
    else
        python3 -m venv "${venv}"
    fi

    if (( ! CHECK_ONLY )); then
        "${venv}/bin/pip" install --quiet pynvim
    fi

    if ! has_cmd nvim; then
        log "nvim not found; skipping plugin installation"
        return 0
    fi
    if (( CHECK_ONLY )); then
        log "Plugins: run nvim --headless '+PlugInstall --sync' +qa"
    else
        nvim --headless "+PlugInstall --sync" +qa
    fi
}

configure_fonts() {
    local fontdir="${HOME}/.local/share/fonts/SauceCodePro"
    if [ -n "$(ls -A "${fontdir}" 2>/dev/null)" ]; then
        installed "fonts (SauceCodePro)"
        return 0
    fi
    if (( CHECK_ONLY )); then
        missing "fonts (SauceCodePro)"
        return 0
    fi
    log "Installing fonts..."
    mkdir -p "${fontdir}"
    curl -fsSL -o "${HOME}/.local/share/fonts/SourceCodePro.tar.xz" https://github.com/ryanoasis/nerd-fonts/releases/download/v3.5.0/SourceCodePro.tar.xz
    tar xf "${HOME}/.local/share/fonts/SourceCodePro.tar.xz" --exclude=LICENSE.txt --exclude=README.md -C "${fontdir}/"
    rm -f "${HOME}/.local/share/fonts/SourceCodePro.tar.xz"
}

configure_icons() {
    local src dest
    for src in "${DOTFILES_DIR}"/icons/*; do
        dest="/usr/local/share/$(basename "${src}")"
        if [ -L "${dest}" ] && [ "$(readlink -f "${dest}")" = "$(readlink -f "${src}")" ]; then
            installed "icon $(basename "${src}")"
        elif (( CHECK_ONLY )); then
            missing "icon $(basename "${src}")"
        else
            sudo ln -sfn "${src}" "${dest}"
        fi
    done
}

configure_themes() {
    local layan_theme="${HOME}/.local/share/plasma/desktoptheme/Layan"
    local tela_icons="${HOME}/.local/share/icons/Tela-purple"
    local sddm_theme='/usr/share/sddm/themes/Layan'
    if [ -d "${layan_theme}" ] && [ -d "${tela_icons}" ] &&
        { [ -d "${sddm_theme}" ] || [ -d '/usr/local/share/sddm/themes/Layan' ]; }; then
        installed "themes (Layan, Tela)"
        return 0
    fi
    if (( CHECK_ONLY )); then
        missing "themes (Layan, Tela)"
        return 0
    fi
    log "Installing system and sddm themes..."
    rm -rf "${HOME}/Layan-kde" "${HOME}/Tela-icons"
    git clone -q --depth 1 https://github.com/vinceliuice/Layan-kde "${HOME}/Layan-kde"
    bash "${HOME}/Layan-kde/install.sh"
    sudo bash "${HOME}/Layan-kde/sddm/5.0/install.sh"
    git clone -q --depth 1 https://github.com/vinceliuice/Tela-icon-theme "${HOME}/Tela-icons"
    bash "${HOME}/Tela-icons/install.sh" purple
    rm -rf "${HOME}/Layan-kde" "${HOME}/Tela-icons"
}

if (( CHECK_ONLY )); then
    log "Checking configuration (no changes will be made)..."
else
    log "Configuring dotfiles and desktop..."
fi

configure_dotfiles
configure_neovim
configure_fonts
configure_icons
configure_themes

if (( CHECK_ONLY )); then
    log "Check complete."
else
    log "All configuration applied."
fi
