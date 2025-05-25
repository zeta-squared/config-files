#!/bin/bash

DOTFILES_DIR=$(dirname "$(realpath $0)")

echo "========================================================================="
echo ""
echo "THIS IS AN INTERACTIVE INSTALLATION"
echo "Make sure to respond when asked for input during the installation process"
echo ""
echo "========================================================================="
echo ""
read -p "Are you ready to continue? [y/N] " CONTINUE
if [[ ${CONTINUE} != "y" ]]; then
    echo "Exiting setup..."
    exit 1
fi


echo "Installing curL..."
sudo apt install curl
echo "Successfully installed curL."

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
sudo apt install python3-venv
echo "Successfully installed python3-venv."

echo "Installing node with pnpm..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
\. "$HOME/.nvm/nvm.sh"
nvm install 22
node -v # Should print "v22.15.0".
nvm current # Should print "v22.15.0".
corepack enable pnpm
pnpm -v
echo "Successfully installed node with pnpm."

echo "Downloading Golang..."
FILE='go1.24.3.linux-amd64.tar.gz'
curl -o ${DOTFILES_DIR}/${FILE} -L https://go.dev/dl/${FILE}
echo "Extracting tarball..."
tar xzf ${DOTFILES_DIR}/${FILE} -C ${DOTFILES_DIR}
echo "Installing Golang..."
sudo rm -rf /usr/local/go/
sudo mv ${DOTFILES_DIR}/go/ /usr/local/
echo "Cleaning up..."
rm -rf ${DOTFILES_DIR}/${FILE}
echo "Successfully installed Golang."

echo "Downloading ripgrep..."
FILE='ripgrep-14.1.1-x86_64-unknown-linux-musl'
curl -o ${DOTFILES_DIR}/${FILE}.tar.gz -L https://github.com/BurntSushi/ripgrep/releases/download/14.1.1/${FILE}.tar.gz
echo "Extracting tarball..."
tar xzf ${DOTFILES_DIR}/${FILE}.tar.gz -C ${DOTFILES_DIR}
echo "Installing ripgrep..."
sudo mv ${DOTFILES_DIR}/${FILE}/rg /usr/local/bin/
sudo mv ${DOTFILES_DIR}/${FILE}/doc/rg.1 /usr/local/man/man1/
echo "Cleaning up..."
rm -rf ${DOTFILES_DIR}/${FILE}*
echo "Successfully installed ripgrep."

echo "Downloading fd..."
FILE='fd-v10.2.0-x86_64-unknown-linux-musl'
curl -o ${DOTFILES_DIR}/${FILE}.tar.gz -L https://github.com/sharkdp/fd/releases/download/v10.2.0/${FILE}.tar.gz
echo "Extracting tarball..."
tar xzf ${DOTFILES_DIR}/${FILE}.tar.gz -C ${DOTFILES_DIR}
echo "Installing fd..."
sudo mv ${DOTFILES_DIR}/${FILE}/fd /usr/local/bin/
sudo mv ${DOTFILES_DIR}/${FILE}/fd.1 /usr/local/man/man1/
echo "Cleaning up..."
rm -rf ${DOTFILES_DIR}/${FILE}*
echo "Successfully installed fd."

echo "Downloading fzf..."
FILE='fzf-0.62.0-linux_amd64'
curl -o ${DOTFILES_DIR}/${FILE}.tar.gz -L https://github.com/junegunn/fzf/releases/download/v0.62.0/${FILE}.tar.gz
echo "Extrating tarball..."
tar xzf ${DOTFILES_DIR}/${FILE}.tar.gz -C ${DOTFILES_DIR}
echo "Installing fzf..."
sudo mv ${DOTFILES_DIR}/fzf /usr/local/bin/
echo "Cleaning up..."
rm -rf ${DOTFILES_DIR}/${FILE}*
echo "Successfully installed fzf."

echo "Downloading lazygit..."
FILE='lazygit_0.50.0_Linux_x86_64'
curl -o ${DOTFILES_DIR}/${FILE}.tar.gz -L https://github.com/jesseduffield/lazygit/releases/download/v0.50.0/${FILE}.tar.gz
echo "Extracting tarball..."
tar xzf ${DOTFILES_DIR}/${FILE}.tar.gz --exclude=LICENSE --exclude=README.md -C ${DOTFILES_DIR}
echo "Installing lazygit..."
sudo mv ${DOTFILES_DIR}/lazygit /usr/local/bin
echo "Cleaning up..."
rm -rf ${DOTFILES_DIR}/${FILE}*
echo "Successfully installed lazygit."

echo "Installing dotfiles..."
ln -sf -t ${HOME} ${DOTFILES_DIR}/.bashrc ${DOTFILES_DIR}/.gitconfig
ln -sf ${DOTFILES_DIR}/config/* ${HOME}/.config/
rm -rf ${HOME}/.local/share/konsole
ln -sf ${DOTFILES_DIR}/local/* ${HOME}/.local/share/
echo "Successfully installed dotfiles."

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
npm i -g tree-sitter-cli
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
echo "Creating python provider for neovim..."
python3 -m venv ${HOME}/.local/share/nvim/nvim_venv
source ${HOME}/.local/share/nvim/nvim_venv/bin/activate
pip install pynvim
deactive
echo "Running plugin installation..."
/usr/local/bin/nvim -c PlugInstall -c q -c q
echo "Cleaning up..."
rm -rf ${DOTFILES_DIR}/${FILE}*
echo "Successfully installed neovim."

echo "Installing fonts..."
mkdir -p ${HOME}/.local/share/fonts/
curl -o ${HOME}/.local/share/fonts/SourceCodePro.tar.xz\
    -L https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/SourceCodePro.tar.xz
tar xf ${HOME}/.local/share/fonts/SourceCodePro.tar.xz --exclude=LICENSE.txt --exclude=README.md -C ${HOME}/.local/share/fonts/
echo "Cleaning up..."
rm -f ${HOME}/.local/share/fonts/SourceCodePro.tar.xz
echo "Fonts have been installed."

echo "Installing system and sddm themes..."
sudo cp -rf ${DOTFILES_DIR}/icons/* /usr/share/icons/
git clone https://github.com/vinceliuice/Layan-kde ${HOME}/Layan-kde
bash ${HOME}/Layan-kde/install.sh
sudo bash ${HOME}/Layan-kde/sddm/6.0/install.sh
git clone https://github.com/vinceliuice/Tela-icon-theme ${HOME}/Tela-icons
bash ${HOME}/Tela-icons/install.sh purple
rm -rf ${HOME}/Layan-kde ${HOME}/Tela-icons
echo "Successfully installed system and sddm themes."

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
sudo groupadd docker
sudo usermod -aG docker ${USER}
echo "Successfully installed docker."
