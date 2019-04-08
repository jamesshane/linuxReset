#!/bin/bash

if [ "$1" == "" ]; then
        echo "makestage <file> || downstage <file> || resetuser <user>"
fi

if [ "$1" == "makestage" ]; then
    if [ "$2" == "" ]; then
        echo "need file name: e.g. makestage stage1"
        exit 1
    fi
    dpkg --get-selections > $2
fi

if [ "$1" == "downstage" ]; then
    if [ "$2" == "" ]; then
        echo "need file name: e.g. downstage stage1"
        exit 1
    fi
    dpkg --clear-selections
    dpkg --set-selections < $2
    dpkg --purge `dpkg --get-selections | grep deinstall | cut -f1`
    echo "I'd reboot."
fi

if [ "$1" == "resetuser" ]; then
    if [ "$2" == "" ]; then
        echo "need user name: e.g. resetuser username"
        exit 1
    fi
    deluser $2
    adduser $2
fi