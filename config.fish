thefuck --alias | source

set -x GOPATH $HOME/workspace/go
set -x PATH $PATH $GOPATH/bin

set -g theme_short_path yes

alias npmcis="npm run clean ;and npm i ;and npm start"
alias gpom="git pull origin master"
