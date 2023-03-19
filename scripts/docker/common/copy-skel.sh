#!/bin/sh

if [ -z $SKEL_PATH ]; then
    SKEL_PATH=/opt/pi/skel
fi

if [ -z $TARGET ]; then
    TARGET=main
fi

/bin/echo "copy skel from $SKEL_PATH/$TARGET to $1"

cp -fr $SKEL_PATH/$TARGET/* $1
cp -fr $SKEL_PATH/$TARGET/.* $1
