# Getting started
----------------------
This nvim config is a Neovim setup powered by lazy.nvim as the pm

## Features
---------------
- transform your nvim into a powerfull IDE (don't nead to RTFM for the plugins)
- Easily customize your config with lazy.nvim
- FAST!
- Sane default settings for options & keymaps & autocmds
- already ready for the rust & go developing!
- Buitiful smooth cursor with smear-cursor.nvim!
- with default 3 built-in ausome theme!: everforest, catppuccin, tokyonight

## Requirements
----------------
- Neovim >= v11.x (for built in lua JIT & smear-cursor.nvim)
- an C compiler for nvim-treesitter
- git >= v2.19.0 (for plugins installations)
- a Nerd Font >= v3.x for your terminal (optional, but needed for icons)
- lazygit (optional)
- for searchings
    - fzf >= v0.25.1
    - ripgrep
    - fd
- a good terminal supports true color & undercurl
    - top recommended
        - iterm2 (MacOS)
        - kitty (Linux & MacOS)
        - wezterm (Linux & MacOS & Windows)
        - alacritty (Linux & MacOs & Windows)
    - sec recommended
        - windows terminal (Windows) # wezterm is better
        - tabby (Linux & MacOS & Windows) # still OK, but wezterm is better

# Installation
-----------------

## For Mac & Linux
--------------

- Make backup for current config
```bash
# required
mv ~/.config/nvim{,.bak}

# optional but recommended
mv ~/.local/share/nvim{,.bak}
mv ~/.local/state/nvim{,.bak}
mv ~/.cache/nvim{,.bak}
```

- Clone starter
```bash
git clone https://github.com/balls-6g/nvim-config ~/.config/nvim
```

- remove the git folder
```bash
rm -rf ~/.config/nvim/.git
```

- And start neovim!
```bash
nvim
```

## For windows
-----------------

- Make backup for current config
```ps1
# required
Move-Item $env:LOCALAPPDATA\nvim $env:LOCALAPPDATA\nvim.bak

# optional but recommended
Move-Item $env:LOCALAPPDATA\nvim-data $env:LOCALAPPDATA\nvim-data.bak
```

- Clone starter
```ps1
git clone https://github.com/balls-6g/nvim-config ~/.config/nvim
```

- remove the git folder
```ps1
Remove-Item $env:LOCALAPPDATA\nvim\.git --Rescurse -Force
```

- And start neovim!
```ps1
nvim
```
