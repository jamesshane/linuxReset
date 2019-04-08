#!/bin/bash

if [ "$1" == "" ]; then
        echo "makestage <file> || downstage <file> || resetuser <user>"
fi

if [ "$1" == "makestage" ]; then
    if [ "$2" != ""]; then
        echo "need file name: e.g. makestage stage1"
        exit 1
    fi
    dpkg --get-selections > $2
fi

if [ "$1" == "downstage" ]; then
    if [ "$2" != ""]; then
        echo "need file name: e.g. downstage stage1"
        exit 1
    fi
    dpkg --clear-selections
    dpkg --set-selections < $2
    apt-get dselect-upgrade
    echo "I'd reboot."
fi

if [ "$1" == "resetuser" ]; then
    if [ "$2" != ""]; then
        echo "need user name: e.g. resetuser username"
        exit 1
    fi
    cd /home/$2
    rm -fr *
    rm -fr .*
    cp /etc/skel/.* .
    chown $2:$2 /home/$2/.*
    chsh -s /bin/bash $2
fi