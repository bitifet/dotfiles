[ -z "$TMUX" ] && export TERM=screen.xterm-256color
set -o vi

alias less="less -R"

# lsd - ls downloads:
alias lsd="ls -lht ~/Baixades/ | head"

# pickd - Pick last downloaded file to current directory:
alias pickd='mv -i ~/Baixades/"$(ls -t1 ~/Baixades | head -n 1)" ./'

# some more ls aliases
alias ll='LC_ALL=C ls -1F'
alias lll='LC_ALL=C ls -lF'
alias la='LC_ALL=C ls -A'
alias l='LC_ALL=C ls -CF'

# Own bin dir:
export PATH="${PATH}:${HOME}/.local/bin"

# Keep prompt short:
export PROMPT_DIRTRIM=2

# "open" command:
alias open='xdg-open'

# OpenAI:
[ -f ~/.config/openai.token ] && export CHAT_GPT_KEY=$(cat ~/.config/openai.token)

# Legacy SSH:
alias lssh='/usr/bin/ssh -o KexAlgorithms=diffie-hellman-group14-sha1 -oHostKeyAlgorithms=+ssh-dss'
# Credits: https://askubuntu.com/a/885396/585248

# Mosh escape key: use Ctrl+Space instead of Ctrl+^ (awkward on Spanish layout)
# Alternatives: '@'=Ctrl+Space, '\'=Ctrl+\, '^'=Ctrl+^ (default)
export MOSH_ESCAPE_KEY='@'

# Disable terminal XON/XOFF flow control so Ctrl+S / Ctrl+Q reach apps
# (superfile uses Ctrl+Q to quit).
stty -ixon 2>/dev/null || true

# superfile (terminal file manager): follow the shell to the last visited dir
# on quit. Sets the editor wrapper and sources superfile's lastdir file.
spf() {
    export EDITOR=spf-editor
    if [ "$(uname -s)" = "Darwin" ]; then
        export SPF_LAST_DIR="$HOME/Library/Application Support/superfile/lastdir"
    else
        export SPF_LAST_DIR="${XDG_STATE_HOME:-$HOME/.local/state}/superfile/lastdir"
    fi
    command spf "$@"
    [ ! -f "${SPF_LAST_DIR:-}" ] || {
        . "$SPF_LAST_DIR"
        rm -f -- "$SPF_LAST_DIR" >/dev/null
    }
}

# Git prompt:
source ~/.local/bin/git-prompt.sh
PS1="${PS1:0:${#PS1}-3}\$(__git_ps1)\\$ "

# Git custom commands:
source ~/.config/bash/git_commands.sh
