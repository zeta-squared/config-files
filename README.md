# My Config Files

This repository contains configuration files for my installation on both KDE and Cinnamon desktop
environments. The below instructions are ordered as

1. [Programs](#programs)
2. [Program Configuration](#program-configuration)
3. [KDE](#kde)
4. [Mason](#mason)
5. [Cinnamon](#cinnamon)

Instructions 1. and 2. must be followed regardless of desktop environments. Afterwards, only follow the
instructions for the installed desktop environment.

> [!IMPORTANT]
> Always check to make sure the referenced directory in the instructions below exist. If they do not create
> them.

## Programs

### Neovim

Download the prebuilt tarball from the [GitHub releases](https://github.com/neovim/neovim/releases) and follow
the instructions to extract. Then copy the contents of `bin/`, `/lib/` and `share/` to the repsectively named
directory in `/usr/local/`.

In order to manage plugins we will use vim-plug. You can find installation
instructions on the vim-plug [GitHub repo](https://github.com/junegunn/vim-plug). Since neovim requires python
integration for UltiSnips to work you will need to create a python venv with pynvim installed. Use the
following commands to install this,
```
cd ~/.local/share/nvim
python3 -m venv nvim_venv
source nvim_venv/bin/activate
pip install pynvim
```

### Ripgrep

Download the `.deb` file from [GitHub](https://github.com/BurntSushi/ripgrep/releases) then use `apt` to
install.

### FZF

Download the prebuilt tarball from the [GitHub releases](https://github.com/junegunn/fzf/releases). Once
extracted place the binary in `/usr/local/bin/`.

### Node and npm

Follow the instructions on the [Node webpage](https://nodejs.org/en/download).

### Treesitter

This is only required if you want to build parsers from source. Otherwise, leave this.

```npm i -g tree-sitter-cli```

### Zathura

```sudo apt install zathura```

### Yakuake

```sudo apt install yakuake```

### GitHub CLI

```sudo apt install gh```

### Lazygit

Follow the installation instructions on [GitHub](https://github.com/jesseduffield/lazygit/tree/master).

## Program Configuration

### Neovim

```
cp -r -t ~/.local/share/nvim nvim/Ultisnips nvim/spell
cp -r -t ~/.config/nvim nvim/lua nvim/ftplugin nvim/init.lua
cp nvim/pycodestyle ~/.config/
```

### Zathura

```
cp -r user/zathura/ ~/.config/
```

### Yakuake

```
cp user/yakuakerc ~/.config/
cp -t ~/.local/share/konsole konsole/
```
Do not blur the background on yakuake.

### iTerm2 (Mac Only)

Using the iTerm2 settings import profiles from `user/iTerm2Profiles.json`.

### Bash

```
cp user/.bashrc ~/
```

### Git

```
cp user/.gitconfig ~/
cp -t ~/.config/autostart/ user/org.kde.yakuake.desktop user/git.sh.desktop
cp user/git.sh ~/.config/old-autostart-scripts
```

### GitHub CLI

```
cp -t ~/.config/gh gh/*
```
Place each accounts access token in the respective `hosts.yml.*` file.

### Lazygit

```
cp -r user/lazygit ~/.config/
```

## KDE

Ensure the zip file in `local/fonts` is unzipped after copying.
```
sudo cp -r icons/* /usr/share/icons/
sudo apt install qt5-style-kvantum
cp -r kvantum/* ~/.config/Kvantum
cp -r local/* ~/.local/share
sudo cp -r sddm/* /usr/share/sddm/themes
```

## Mason

Mason is used to manage LSP servers, DAP servers, linters, and formatters. For our purposes we need to install
the following.

### LSP servers

- python-lsp-server
- texlab
- typescript-language-server
- yaml-language-server

### DAP servers

- debugpy
- firefox-debug-adapter

For the DAP to work you need to include a `.vscode/launch.json` file in each project to configure the DAP. The
below code snippet is a simple example for a Python-Flask project.

```
{
    "name": "Python Debugger: Flask",
    "type": "debugpy",
    "request": "launch",
    "module": "flask",
    "env": {
        "FLASK_APP": "app.py",
        "FLASK_DEBUG": "1"
    }
    "args": ["run"],
    "jinja": true,
    "justMyCode": true
}
```

The `env` property can be dropped if your project contains a `.flask_env` file.

## Cinnamon

Download and install the following GitHub repos,

- [Orchis-theme](https://github.com/vinceliuice/Orchis-theme): `./install.sh -t purple`.
- [Tela-circle-icon-theme](https://github.com/vinceliuice/Tela-circle-icon-theme): `./install.sh purple`.

Next install the nautilus file explorer with
```
sudo apt install nautilus nautilus-extension-gnome-terminal
```
Finally install the cursors with
```
sudo cp -r kde/icons/LyraF-cursors /usr/share/icons
```

## Terminal Color Scheme

| Colour | Default HTML | Intense HTML |
| - | - | - |
| 0 |  #d86ca2 | #ff7fbf |
| 1 | #e34337 | #f8493c |
| 2 | #e68782 | #ff9790 |
| 3 | #f67400 | #fdbc4b |
| 4 | #1d99f3 | #3daee9 |
| 5 | #ca4367 | #ff557f |
| 6 | #8ee274 | #9eff83 |
| 7 | #9b59b6 | #9b59b6 |
| BG | #232627 | #000000 |
| FG | #ffffff | #ffffff |

Colour 5 and colour 5 intense may need to be switched to match Konsole.
