thefuck --alias | source

set -x GOPATH $HOME/workspace/go
set -x PATH $PATH $GOPATH/bin

/*makes fish prompt colors different*/
set pure_color_blue (set_color "638ffa")
set pure_color_green (set_color "84fba2")

alias npmcis="npm run clean ;and npm i ;and npm start"
alias gpom="git pull origin master"
