PS1='[\[\e[32m\]\W\[\e[0m\]] '

if [ -f /usr/share/bash-completion/bash_completion ]; then
  . /usr/share/bash-completion/bash_completion
elif [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
fi

alias ls='lsd'

alias path='pwd'
