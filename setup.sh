#!/bin/bash

DOTFILES_DIR=$(dirname "$(realpath $0)")

echo "Installing curL..."
sudo apt install curl
echo "Successfully installed curL."

echo "Downloading neovim..."
FILE='nvim-linux-x86_64'
curl -o ${DOTFILES_DIR}/${FILE}.tar.gz -L https://github.com/neovim/neovim/releases/download/v0.11.1/${FILE}.tar.gz
echo "Extracting tarball..."
tar xzf ${DOTFILES_DIR}/${FILE}.tar.gz -C ${DOTFILES_DIR}
echo "Installing neovim..."
sudo cp -rf ${DOTFILES_DIR}/${FILE}/bin/* /usr/local/bin/
sudo cp -rf ${DOTFILES_DIR}/${FILE}/lib/* /usr/local/lib/
sudo cp -rf ${DOTFILES_DIR}/${FILE}/share/* /usr/local/share/
echo "Installing dependencies for neovim..."
sudo apt install xclip
echo "Cleaning up..."
rm -rf ${DOTFILES_DIR}/${FILE}*
echo "Successfully installed neovim."

echo "Downloading ripgrep..."
FILE='ripgrep-14.1.1-x86_64-unknown-linux-musl'
curl -o ${DOTFILES_DIR}/${FILE}.tar.gz -L https://github.com/BurntSushi/ripgrep/releases/download/14.1.1/${FILE}.tar.gz
echo "Extracting tarball..."
tar xzf ${DOTFILES_DIR}/${FILE}.tar.gz -C ${DOTFILES_DIR}
echo "Installing ripgrep..."
sudo cp -f ${FILE}/rg /usr/local/bin/
sudo cp -f ${FILE}/doc/rg.1 /usr/local/man/man1/
echo "Cleaning up..."
rm -rf ${DOTFILES_DIR}/${FILE}*
echo "Successfully installed ripgrep."

echo "Downloading fzf..."
curl -o ${DOTFILES_DIR}/fzf-0.62.0-linux_amd64.tar.gz -L https://github.com/junegunn/fzf/releases/download/v0.62.0/fzf-0.62.0-linux_amd64.tar.gz
echo "Extrating tarball..."
tar xzf ${DOTFILES_DIR}/fzf-0.62.0-linux_amd64.tar.gz -C ${DOTFILES_DIR}
echo "Installing fzf..."
sudo mv ${DOTFILES_DIR}/fzf /usr/local/bin/
echo "Cleaning up..."
rm -rf ${DOTFILES}/fzf-*
echo "Successfully installed fzf."

echo "Installing vim-plug..."
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
echo "Vim-plug has been installed."

echo "Installing node with pnpm..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
\. "$HOME/.nvm/nvm.sh"
nvm install 22
node -v # Should print "v22.15.0".
nvm current # Should print "v22.15.0".
corepack enable pnpm
pnpm -v
echo "Successfully installed node with pnpm."

echo "Installing zathura..."
sudo apt install zathura
echo "Successfully installed zathura."

echo "Installing yakuake..."
sudo apt install yakuake
echo "Successfully installed yakuake."

echo "Installing gh..."
sudo apt install gh
echo "Successfully installed gh."

echo "Installing kvantum..."
sudo apt install qt5-style-kvantum
echo "Successfully installed kvantum."

echo "Install GCC..."
sudo apt install gcc
echo "Successfully installed gcc."

echo "Installing python3-venv..."
sudo sudo apt install python3-venv
echo "Successfully installed python3-venv."

echo "Downloading lazygit..."
curl -o ${DOTFILES_DIR}/lazygit-0.50.0_Linux_x86_64.tar.gz -L https://github.com/jesseduffield/lazygit/releases/download/v0.50.0/lazygit_0.50.0_Linux_x86_64.tar.gz
echo "Extracting tarball..."
tar xzf ${DOTFILES_DIR}/lazygit-0.50.0_Linux_x86_64.tar.gz -C ${DOTFILES_DIR}
echo "Installing lazygit..."
sudo mv ${DOTFILES_DIR}/lazygit /usr/local/bin
echo "Cleaning up..."
rm -rf ${DOTFILES_DIR}/lazygit-* LICENSE
echo "Successfully installed lazygit."

echo "Installing dotfiles..."
cp -ft ${HOME} ${DOTFILES_DIR}/.bashrc ${DOTFILES_DIR}/.gitconfig
cp -rf ${DOTFILES_DIR}/config/* ${HOME}/.config/
cp -rf ${DOTFILES_DIR}/local/* ${HOME}/.local/share/
echo "Successfully installed dotfiles."

echo "Installing fonts..."
mkdir -p ${HOME}/.local/share/fonts/
curl -o ${HOME}/.local/share/fonts/SourceCodePro.tar.xz\
    -L https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/SourceCodePro.tar.xz
tar xf ${HOME}/.local/share/fonts/SourceCodePro.tar.xz --exclude=LICENSE.txt --exclude=README.md -C ${HOME}/.local/share/fonts/
echo "Cleaning up..."
rm -f ${HOME}/.local/share/fonts/SourceCodePro.tar.xz
echo "Fonts have been installed."

echo "Installing system cursors and sddm theme..."
sudo cp -rf ${DOTFILES_DIR}/icons/* /usr/share/icons/
sudo cp -rf ${DOTFILES_DIR}/sddm/* /usr/share/sddm/themes/
echo "Successfully installed system cursors and sdd theme."

echo "Creating python provider for neovim..."
python3 -m venv ${HOME}/.local/share/nvim/nvim_venv
source ${HOME}/.local/share/nvim/nvim_venv/bin/activate
pip install pynvim
deactive
echo "Python provider setup complete."

echo "Running plugin installation in neovim..."
/usr/local/bin/nvim -c PlugInstall -c q -c q
echo "Successfully installed neovim plugins."

echo "Installing Firefox..."
sudo add-apt-repository ppa:mozillateam/ppa
echo '
Package: *
Pin: release o=LP-PPA-mozillateam
Pin-Priority: 1001

Package: firefox
Pin: version 1:1snap*
Pin-Priority: -1
' | sudo tee /etc/apt/preferences.d/mozilla-firefox
sudo apt install firefox
echo 'Unattended-Upgrade::Allowed-Origins:: "LP-PPA-mozillateam:${distro_codename}";' | sudo tee /etc/apt/apt.conf.d/51unattended-upgrades-firefox
echo "Successfully installed Firefox."

echo "Setting up Docker's apt repository..."
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
echo "Installing docker..."
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
echo "Configuring group to manage docker as non-root user..."
sudo usermod -aG docker $USER
newgrp docker
echo "Successfully installed docker."
