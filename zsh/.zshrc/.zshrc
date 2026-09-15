# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

export ZSH="$HOME/.oh-my-zsh"
export PATH="$HOME/.local/bin:$PATH"

ZSH_THEME="af-magic"
PROMPT='%~ $ '

plugins=(
    git
    archlinux
    zsh-autosuggestions
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh
# Check archlinux plugin commands here
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/archlinux

# fastfetch. Will be disabled if above colorscript was chosen to install
fastfetch --logo Bonsai

# Set-up icons for files/directories in terminal using lsd
alias backupsp='rclone sync /media/shared drive:BACKUP --progress'
alias ls='lsd --color=never'
alias cdu='cd /media/shared/UNIVERSITY'
alias remotestart='~/Documents/remote-project/remotestart.sh'
alias l='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias lt='ls --tree'
alias gccp='gcc -Wall -ansi -pedantic-errors'
alias mounttssd='sudo mount -o uid=1000,gid=1000,umask=022 /dev/sda1 /media/tssd'
alias umounttssd='sudo umount /dev/sda1'
alias gthear='pactl load-module module-loopback \
    source=alsa_input.usb-BOSS_GX-100-00.analog-stereo \
    sink=alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__Speaker__sink \
    latency_msec=10
'
alias conda-on='source ~/anaconda3/bin/activate'
alias totostart='cd /media/shared/projects/toto-v1 && ./start.sh'
alias code='code --enable-proposed-api ms-toolsai.jupyter --enable-proposed-api ms-python.python'

# Set-up FZF key bindings (CTRL R for fuzzy history finder)
source <(fzf --zsh)
export PATH="$HOME/.cargo/bin:$PATH"


HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory


export PATH=$PATH:/home/archie/.spicetify

