# Filename to store/lookup ssh-agent environment variables
SSH_ENV=$HOME/.ssh/environment

function _start_agent() {
    # Check if ssh-agent is already running
    if [[ -f "$SSH_ENV" ]]; then
        . "$SSH_ENV" > /dev/null

        # Test if $SSH_AUTH_SOCK is visible
        zmodload zsh/net/socket
        if [[ -S "$SSH_AUTH_SOCK" ]] && zsocket "$SSH_AUTH_SOCK" 2>/dev/null; then
          return 0
        fi
    fi

    if [[ ! -d "$HOME/.ssh" ]]; then
        echo "[zsh] ssh-agent plugin requires ~/.ssh directory"
        return 1
    fi


    # Set a maximum lifetime for identities added to ssh-agent
    local lifetime
    zstyle -s :plugins:ssh-agent lifetime lifetime

    # Start ssh-agent and setup environment
    ssh-agent -s ${lifetime:+-t} ${lifetime} | sed '/^echo/d' >! "$SSH_ENV"
    chmod 600 "$SSH_ENV"
    . "$SSH_ENV" > /dev/null
}


# Persist the SSH_AUTH_SOCK environment variable when using multiplexers (e.g. tmux)
if [[ -n "$SSH_AUTH_SOCK" ]]; then
    if [[ ! -L "$SSH_AUTH_SOCK" ]]; then
        # Create a symlink for the SSH agent socket
        ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
        export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
    fi
else
    _start_agent
fi

unset SSH_ENV
unfunction _start_agent
