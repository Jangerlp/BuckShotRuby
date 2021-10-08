FROM ubuntu

RUN apt update
RUN apt-get install -y wget
RUN apt install mruby libmruby-dev
RUN url='https://raw.githubusercontent.com/simple2d/simple2d/master/bin/simple2d.sh'; which curl > /dev/null && cmd='curl -fsSL' || cmd='wget -qO -'; bash $($cmd $url) install
RUN ruby2d build Main.rb
