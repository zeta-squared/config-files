#!/bin/bash

DOTFILES_DIR=$(dirname "$(realpath $0)")

echo "Downloading neovim..."
curl -o ${DOTFILES_DIR}/nvim-linux-x86_64.tar.gz -L https://github.com/neovim/neovim/releases/download/v0.11.1/nvim-linux-x86_64.tar.gz
echo "Extracting tarball..."
tar xzf ${DOTFILES_DIR}/nvim-linux-x86_64.tar.gz -C ${DOTFILES_DIR}
echo "Installing neovim..."
cp ${DOTFILES_DIR}/nvim-linux-x86_64/bin/* /usr/local/bin/
cp ${DOTFILES_DIR}/nvim-linux-x86_64/lib/* /usr/local/lib/
cp ${DOTFILES_DIR}/nvim-linux-x86_64/share/* /usr/local/share/
echo "Cleaning up..."
rm -rf ${DOTFILES_DIR}/nvim-linux-x86*
echo "Successfully installed neovim."

echo "Downloading ripgrep..."
curl -o ${DOTFILES_DIR}/ripgrep.deb -L https://github.com/BurntSushi/ripgrep/releases/download/14.1.1/ripgrep_14.1.1-1_amd64.deb
echo "Installing ripgrep..."
apt install ${DOTFILES_DIR}/ripgrep.deb
echo "Cleaning up..."
rm -rf ${DOTFILES_DIR}/ripgrep.deb
echo "Successfully installed ripgrep."

echo "Downloading fzf..."
curl -o ${DOTFIILES_DIR}/fzf-0.62.0-linux_amd64.tar.gz -L https://github.com/junegunn/fzf/releases/download/v0.62.0/fzf-0.62.0-linux_amd64.tar.gz
echo "Extrating tarball..."
tar xzf ${DOTFILES_DIR}/fzf-0.62.0-linux_amd64.tar.gz -C ${DOTFILES_DIR}
echo "Installing fzf..."
mv ${DOTFILES_DIR}/fzf /usr/local/bin/
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

echo "Setting up Docker's apt repository..."
apt-get update
apt-get install ca-certificates curl
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update
echo "Installing docker..."
apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
echo "Configuring group to manage docker as non-root user..."
groupadd docker
usermod -aG docker $USER
newgrp docker
echo "Successfully installed docker."

echo "Installing zathura..."
apt install zathura
echo "Successfully installed zathura."

echo "Installing yakuake..."
apt install yakuake
echo "Successfully installed yakuake."

echo "Installing gh..."
apt install gh
echo "Successfully installed gh."

echo "Installing kvantum..."
apt install qt5-style-kvantum
echo "Successfully installed kvantum."

echo "Downloading lazygit..."
curl -o ${DOTFILES_DIR}/lazygit-0.50.0_Linux_x86_64.tar.gz -L https://github.com/jesseduffield/lazygit/releases/download/v0.50.0/lazygit_0.50.0_Linux_x86_64.tar.gz
echo "Extracting tarball..."
tar xzf ${DOTFILES_DIR}/lazygit-0.50.0_Linux_x86_64.tar.gz -C ${DOTFILES_DIR}
echo "Installing lazygit..."
mv ${DOTFILES_DIR}/lazygit /usr/local/bin
echo "Cleaning up..."
rm -rf ${DOTFILES_DIR}/lazygit-* LICENSE
echo "Successfully installed lazygit."

echo "Installing dotfiles..."
cp -ft ${HOME} ${DOTFILES_DIR}/.bashrc ${DOTFILES_DIR}/.gitconfig
source ${HOME}/.bashrc
cp -rf ${DOTFILES_DIR}/config/* ${HOME}/.config/
cp -rf ${DOTFILES_DIR}/local/* ${HOME}/.local/share/
echo "Successfully installed dotfiles."

echo "Installing fonts..."
mkdir -p ${HOME}/.local/share/fonts/
curl -o ${HOME}/.local/share/fonts/SourceCodePro.zip \
    -L https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/SourceCodePro.zip
unzip ${HOME}/.local/share/fonts/* -x LICENSE.txt README.md -d ${HOME}/.local/share/fonts/
echo "Cleaning up..."
rm -f ${HOME}/.local/share/fonts/SourceCodePro.zip
echo "Fonts have been installed."

echo "Installing system cursors and sddm theme..."
cp -r ${DOTFILES_DIR}/icons/* /usr/share/icons/
cp -r ${DOTFILES_DIR}/sddm/* /usr/share/sddm/themes/
echo "Successfully installed system cursors and sdd theme."

echo "Creating python provider for neovim..."
python -m venv ${HOME}/.local/share/nvim/nvim_venv
source ${HOME}/.local/share/nvim/nvim_venv/bin/activate
pip install pynvim
deactive
echo "Python provider setup complete."

echo "Running plugin installation in neovim..."
/usr/local/bin/nvim -c PlugInstall -c q -c q
echo "Successfully installed neovim plugins."
