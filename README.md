# My Configs
I really hate setting things up more than once so its time to do things properly and version control my config files.

# VIM Keybinds

### CTRL + p
> Telescope

Opens telescope for fuzzy file search

### CTRL + l
> Live Grep

Opens fuzzy text searching across project

### CTRL + n
> Toggle Neotree

Toggles Neotree folder tree on the left of the screen

### gg=G
> Fix Indentation

If in normal mode you type this it will reindent everything correctly. IT IS GOD TIER

### CA
> Code Action

If you use `shift -> c -> a` so basically `CA` while hovering over a block of code that has an error it will suggesst possible fixes and depending on the LSP maybe even perform the fix.

### K
> Documentation Block

While hovering over a code piece if you press `K` or `shift + k` it will offer you a documentation block or signature for the code piece.

### gd 
> Go To Definition

While hovering over a code piece gd is "go to definition"

### GF
Using `shift + g + f` you can apply formatting using none-ls (prev/historically null-ls) which is a language server wrapper almost for linters and formatters

# VIM Behavior

### Neo Tree

Due to Neotree some files in the tree will show up as an alt color (red, orange, whatever). This is because they were not pushed via git yet. It will track unpushed changes in files and show you what needs to be pushed in the tree itself which is cool

### Project Structure

This is what the basic structure of the neovim configs look like. The `nvim` folder should be placed inside of the users `.config/` directory.

```
 (D) ~/dotfiles
   (D) nvim             <- Main neovim config folder
   │ (D) lua            <- Place where all you lua configs go
   │ │ (D) plugins      <- Place where all your individual plugins go
   │ │ └ (F) pluginname.lua     <- Actual plugin file containing plugin config
   │ └ (F) vim-options.lua      <- Contains general nvim options
   └  (F) init.lua              <- Entry point for nvim configs

(D) = Directory
(F) = File
```

# Tha-tha-tha-tha. Thats All Folks
