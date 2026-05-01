# Enable Starship 
eval "$(starship init bash)"

# Enable fzf 
eval "$(fzf --bash)"

# Set default editor to nvim 
export EDITOR="nvim"
export VISUAL="nvim"
export GIT_EDITOR="nvim"

# General Terminal aliases
alias cls='clear' 
alias home='clear && cd'
alias aliasEdit='sudo nvim ~/.bashrc' 
alias bashProfileEdit='sudo nvim ~/.bash_profile'
alias aliasReload='source ~/.bashrc && echo Bashrc sourced!'
alias ff='fastfetch'
alias neofetch='fastfetch'
alias f='z'
alias fp='z ..' 
alias fb=' z -' 
alias fa='zi'
alias copyPath='pwd | clip.exe'                 # Clip.exe specifically for WSL 
alias searchHistory='bat ~/.bash_history | rg'

# Git Related Aliases

# Nix Config Aliases
alias nixConfigEdit='sudo nvim /etc/nixos/configuration.nix' 
alias nixPrograms='sudo nvim /etc/nixos/modules/programs.nix' 

# Nix Commands 
alias nixRebuild='sudo nixos-rebuild switch'
alias nixSearch='nix search nixpkgs' 
alias nixGenerationLs='sudo nix-env --list-generations --profile /nix/var/nix/profiles/system' 
alias nixDelete='sudo nix-collect-garbage -d' 
alias nixDeleteOlderThan='nix profile wipe-history --older-than' 
alias nixTempInstall='nix-shell -p'
alias nixTempRemove='nix-env -e'

# Tmux Related Aliases 
alias tmuxConfigEdit='sudo nvim ~/.tmux.conf'
alias tmuxReload='tmux source-file ~/.tmux.conf && echo Tmux Config Sourced!' 

# Neovim Related Aliases
alias nvimConfigEdit='sudo nvim ~/.config/nvim/init.lua' 
alias nixCatsEdit='sudo nvim /etc/nixos/modules/nixCats.nix'
alias nvimReload='sudo cp ~/.config/nvim/init.lua /root/.config/nvim/ && echo NeoVim Config Reloaded!' 

# WSL Work Related Aliases
alias mathsEdit='f /mnt/d/Documents/University/Year2/ELE225_Maths/mathsNotes && nvim'

# Alacritty WSL related aliases
alias alacrittyConfigEdit='sudo nvim /mnt/c/Users/Rohaan/AppData/Roaming/alacritty/alacritty.toml'

# FZF Colour Scheme 
export FZF_DEFAULT_OPTS='--color=fg:#f8f8f2,bg:#282a36,hl:#bd93f9 --color=fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9 --color=info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6 --color=marker:#ff79c6,spinner:#ffb86c,header:#6272a4'

# Attach if not already inside tmux on startup
if command -v tmux >/dev/null 2>&1; then
    [ -z "$TMUX" ] && exec tmux
fi

# Enable Zoxide (keep at end of file)
eval "$(zoxide init bash)" 
