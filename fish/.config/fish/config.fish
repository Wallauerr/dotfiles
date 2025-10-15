if status is-interactive
    # starship
    starship init fish | source

    # Zellij
    if not set -q ZELLIJ
        exec zellij
    end

    # remove the default fish greeting
    set -U fish_greeting

    # welcome message
    #set -g fish_greeting "Welcome to the fish shell"

    # title
    function fish_title
        echo -n $USER
    end

    # Bun PATH
    set -gx PATH $PATH ~/.bun/bin

    # pnpm PATH
    set -gx PNPM_HOME "/home/wallauer/.local/share/pnpm"
    if not string match -q -- $PNPM_HOME $PATH
        set -gx PATH "$PNPM_HOME" $PATH
    end

    # Node.js version manager (n)
    set -x N_PREFIX ~/.local/n
    set -x PATH ~/.local/n/bin $PATH

    # Local bin
    set -gx PATH ~/.local/bin $PATH

    # Load general variables
    if test -f ~/.env
        source ~/.env
    end

    # alias
    alias l "eza --icons"
    alias lt "eza --tree --icons"
    alias ll yazi
    alias lg lazygit

    # Zed
    if not command -v zed &>/dev/null
        if command -v zeditor &>/dev/null
            alias zed zeditor
        end
    end
end
