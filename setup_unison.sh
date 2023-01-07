#!/bin/bash
echo "#####################################################################"
/usr/bin/figlet                       UNISON INSTALL
echo "#####################################################################"

    mkdir $HOME/tmp >/dev/null 2>/dev/null
    mkdir $HOME/tmp/unison >/dev/null 2>/dev/null
    cd $HOME/tmp/unison
    wget https://github.com/bcpierce00/unison/releases/download/v2.53.0/unison-v2.53.0+ocaml-4.14.0+x86_64.linux.tar.gz
    tar -xf unison-v2.53.0+ocaml-4.14.0+x86_64.linux.tar.gz
    sudo mv bin/uni* /usr/bin
