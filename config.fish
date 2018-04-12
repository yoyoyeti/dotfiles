thefuck --alias | source

set -x GOPATH $HOME/workspace/go
set -x JAVA_HOME (/usr/libexec/java_home -v 1.8)
set -x SCALA_HOME /usr/local/share/scala-2.11.11
set -x ZINC_HOME /usr/local/share/zinc-0.3.13
set -x APP_HOME $HOME/workspace/anthology


set -x PATH $PATH $GOPATH/bin $SCALA_HOME/bin $ZINC_HOME/bin $APP_HOME

set -g theme_short_path yes

alias npmcis="npm run clean ;and npm i ;and npm start"
alias gpom="git pull origin master"
