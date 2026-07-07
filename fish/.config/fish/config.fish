if status is-interactive
    # mise
    if command -qv mise
        mise activate fish | source
    end

    # starship
    starship init fish | source

    # Zellij
    # if not set -q ZELLIJ
    #     exec zellij
    # end

    # remove the default fish greeting
    set -U fish_greeting

    # welcome message
    #set -g fish_greeting "Welcome to the fish shell"

    # title
    function fish_title
        echo -n $USER
    end

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
    alias c opencode

    # Zed
    if not command -v zed &>/dev/null
        if command -v zeditor &>/dev/null
            alias zed zeditor
        end
    end
end
