#!/bin/bash

if [ "$(uname -s)" = "Darwin" ] && which greadlink &> /dev/null; then
    dotfilesDir=$(dirname $(greadlink -f "$0"))
elif [ "$(uname -s)" = "Linux" ]; then
    dotfilesDir=$(dirname $(readlink -f "$0"))
fi

if [ -z $dotfilesDir ]; then
    echo "Unsupported Platform"
    exit 1
fi

for file in `ls -a $dotfilesDir`; do
    if [ -d $file -a $file = '.emacs.d' -o $file = '.scripts' ] || \
       [ -f $file \
         -a ! $file = '.gitmodules' \
         -a ! $file = '.gitignore' \
         -a ${file:0:1} = '.' ]; then

        if [ -e $HOME/$file ]; then
            echo "~/$file exists already."
        else
            ln -s $dotfilesDir/$file $HOME/$file
            echo "created a new link ~/$file."
        fi
    fi
 done
