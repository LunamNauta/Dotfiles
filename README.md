# Bootstrap
In order to bootstrap the Neovim configuration,\
you can use this git command: "git clone https://github.com/LunamNauta/NeovimDotfiles $env:LOCALAPPDATA/nvim"

# Functions
## This configuration has a few functions that allow you to interface with github, these include:

#### :ReloadConfig
Reloads the configuration file.\
This will re-source all lua files, as well as create a fresh instantiation of Neovim.

#### :DownloadConfig
Downloads the configuration from the repository.\
This will overwrite all files in Neovim's configuration path with the files from the repository (specifically, the files from the most recent commit).

#### :UploadConfig
Uploads the configuration to the repository.\
This will commit directly to the main branch.\
This includes all changes that were made under Neovim's configuration path (modified files, created files, removed files, etc).

#### :EditConfig
This opens a buffer to init.lua.\
This allows for easy access to the configuration, without having to search for it in a file explorer.
