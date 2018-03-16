thefuck --alias | source

set -x GOPATH $HOME/workspace/go
set -x PATH $PATH $GOPATH/bin

set -g theme_short_path yes

set fish_color_cwd ff7675

alias npmcis="npm run clean ;and npm i ;and npm start"
alias gpom="git pull origin master"
