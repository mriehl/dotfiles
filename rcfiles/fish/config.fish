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
# -------------

set PYTHONSTARTUP ~/.pythonrc.py

set GOPATH ~/go
