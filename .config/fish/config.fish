if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Override fish greeting
set fish_greeting

# Init abbreviation 
init_abbreviations 

# Init gruvbox theme
init_gruvbox

# Init zoxide
zoxide init fish | source

# Init starship prompt
starship init fish | source
