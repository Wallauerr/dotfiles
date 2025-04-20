if status is-interactive
    # starship
    starship init fish | source

    # welcome message
    #set -g fish_greeting "Welcome to the fish shell"

    # title
    function fish_title
        echo -n $USER
    end

    # alias
    alias l "eza --icons"
    alias ll "eza --tree --icons"
    alias lg lazygit
end
