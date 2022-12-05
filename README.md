# My Neovimfiles


## Installation

```
git clone https://github.com/zealot128/nvim-files.git ~/.config/nvim
git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim

nvim
```

```
:PackerSync
```

## HowTo - Add Language Servers:

```
:LspInstall ...
```

```
nvim ~/.config/nvim/lua/plugins/lspconfig.lua
```

Append config below

## HowTo - Add linter/formatter

```
:Mason
```
