if status is-interactive
    starship init fish | source # Commands to run in interactive sessions can go here
    alias l "eza --icons"
    alias ll "eza --tree --icons"
    alias lg lazygit
end
