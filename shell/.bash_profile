# Source the bashrc file for aliases in tmux 
if [ -f ~/.bashrc ]; then 
	. ~/.bashrc 
fi 

# Start ssh-agent if not running
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    eval "$(ssh-agent -s)"
fi

# Add your key if not already added
ssh-add -l >/dev/null 2>&1 || ssh-add ~/.ssh/id_ed25519

