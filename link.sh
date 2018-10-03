#!/bin/bash

homeDir=`dirname $(readlink -f "$0")`

for file in `ls -a $homeDir`; do
    if [ -f $file \
         -a ! $file = '.gitmodules' \
         -a ! $file = '.gitignore' \
         -a ${file:0:1} = '.' ]; then

        if [ -e $HOME/$file ]; then
            echo "~/$file exists already."
        else
            ln -s $homeDir/$file $HOME/$file
            echo "made link ~/$file."
        fi

    fi
 done
