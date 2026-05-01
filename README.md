This is the backup of all my dotfiles in one directory using GNU stow to create symlinks to their relevent directories (usually within ~/.config)

This setup is incredibly specific to NixOs - with a specific focus on reproducibility within it. However, most tools can be recreated outside of NixOs due to the configuration not using flakes or home-manager. This is with the expception of neovim due to its declarative package management that uses a nixCats setup in conjunction with the init.lua

To create a symlimk simply type stow followed by the name of the directory - except for nixos. For nixos run the command: sudo stow -t /etc/nixos nixos 

NEW: There is an autoStow script that will do all of the above and comes in a NIX and NIX free version.
