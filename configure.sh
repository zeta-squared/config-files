#!/bin/bash

set -euo pipefail

DOTFILES_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

log() { printf '%s\n' "$*"; }

configure_dotfiles() {
    log "Configuring dotfiles..."

    mkdir -p "${HOME}/.config" "${HOME}/.local/share"

    ln -sfn -t "${HOME}" "${DOTFILES_DIR}/.bashrc" \
        "${DOTFILES_DIR}/.gitconfig" "${DOTFILES_DIR}/.tmux.conf"
    ln -sfn "${DOTFILES_DIR}"/config/* "${HOME}/.config/"
    rm -rf "${HOME}/.local/share/konsole"
    ln -sfn "${DOTFILES_DIR}"/local/* "${HOME}/.local/share/"
}

configure_neovim() {
    log "Configuring neovim..."

    local plug_vim="${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/autoload/plug.vim"
    local venv="${HOME}/.local/share/nvim/nvim_venv"

    if [[ ! -f "${plug_vim}" ]]; then
        curl -fsSLo "${plug_vim}" --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    fi

    python3 -m venv "${venv}"
    "${venv}/bin/python" -m pip install --quiet pynvim

    nvim --headless "+PlugInstall --sync" +qa
}

configure_fonts() {
    log "Installing fonts..."

    local fontdir="${HOME}/.local/share/fonts/SauceCodePro"

    mkdir -p "${fontdir}"
    curl -fsSL -o "${HOME}/.local/share/fonts/SourceCodePro.tar.xz" https://github.com/ryanoasis/nerd-fonts/releases/download/v3.5.0/SourceCodePro.tar.xz
    tar xf "${HOME}/.local/share/fonts/SourceCodePro.tar.xz" --exclude=LICENSE.txt --exclude=README.md -C "${fontdir}/"
    rm -f "${HOME}/.local/share/fonts/SourceCodePro.tar.xz"
}

configure_icons_and_themes() {
    log "Installing icons and themes..."

    sudo ln -sfn "${DOTFILES_DIR}"/icons/* /usr/local/share/

    git clone -q --depth 1 https://github.com/vinceliuice/Layan-kde "${HOME}/Layan-kde"
    bash "${HOME}/Layan-kde/install.sh"
    sudo bash "${HOME}/Layan-kde/sddm/5.0/install.sh"
    git clone -q --depth 1 https://github.com/vinceliuice/Tela-icon-theme "${HOME}/Tela-icons"
    bash "${HOME}/Tela-icons/install.sh" purple
    rm -rf "${HOME}/Layan-kde" "${HOME}/Tela-icons"
}

configure_dotfiles
configure_neovim
configure_fonts
configure_icons_and_themes
