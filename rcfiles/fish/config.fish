# Aliases
# -------
alias insecssh='ssh -o "StrictHostKeyChecking=no" -o "UserKnownHostsFile=/dev/null" -o "PreferredAuthentications=keyboard-interactive"'

alias ex='simple-extract'

alias n=' noglob n'

alias pacman-autoremove='sudo pacman -Rns (pacman -Qqtd)'

alias targzlook='tar -ztvf'

alias targzcomp='tar -zcvf'


# Environment-specific config
# ---------------------------

. ~/.is24rc


# Environment
# -----------

set PYTHONSTARTUP ~/.pythonrc.py

set GOPATH ~/go

# Fish config
# -----------

set fish_greeting

set __fish_init_1_22_0:\x1d
set __fish_init_1_50_0:\x1d
set __prompt_initialized_2:\x1d
set fish_color_autosuggestion:000000
set fish_color_command:000000
set fish_color_comment:00af5f
set fish_color_cwd:5fafd7
set fish_color_cwd_root:ff0000
set fish_color_error:red\x1e\x2d\x2dbold
set fish_color_escape:cyan
set fish_color_history_current:cyan
set fish_color_host:808080
set fish_color_match:cyan
set fish_color_normal:normal
set fish_color_operator:cyan
set fish_color_param:00afff\x1ecyan
set fish_color_quote:brown
set fish_color_redirection:normal
set fish_color_search_match:\x2d\x2dbackground\x3dpurple
set fish_color_status:red
set fish_color_user:000000
set fish_color_valid_path:\x2d\x2dunderline
set fish_greeting:\x1d
set fish_key_bindings:fish\x5fdefault\x5fkey\x5fbindings
set fish_pager_color_completion:normal
set fish_pager_color_description:555\x1eyellow
set fish_pager_color_prefix:cyan
set fish_pager_color_progress:cyan
