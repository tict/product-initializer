#!/bin/sh
#
# Usage:
#   cp -r xxx/skel/home /tmp/home
#   DEV_USER_ID=501 DEV_GROUP_ID=501 ./init-user.sh 
#

if [ -z $DEV_USER_ID ]; then
    DEV_USER_ID=1001
fi
if [ -z $DEV_GROUP_ID ]; then
    DEV_GROUP_ID=1001
fi

#
# group and user
#
(id -ng ${DEV_GROUP_ID} || groupadd -g ${DEV_GROUP_ID} developer) && \
    id -nu ${DEV_USER_ID} && (\
        echo 'node:password' | chpasswd && \
        echo 'node ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers \
    ) || (\
        useradd -u ${DEV_USER_ID} -g ${DEV_GROUP_ID} -G sudo dev && \
        mkdir -p /home/dev && \
        chown ${DEV_USER_ID}:${DEV_GROUP_ID} /home/dev && \
        echo 'dev:password' | chpasswd && \
        echo 'dev ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers \
    )

#
# HOME
#
PI_SKEL_HOME=/opt/pi/skel/home

if [ ! -e $PI_SKEL_HOME ]; then
    echo "skip copying files to home"
    exit 0
fi

USER_NAME=`id -nu ${DEV_USER_ID}`

cp -fr $PI_SKEL_HOME/. /home/$USER_NAME/ \
    && rm -fr $PI_SKEL_HOME

if [ -e /home/$USER_NAME/scripts ]; then
    chown -R ${DEV_USER_ID}:${DEV_GROUP_ID} /home/$USER_NAME \
        && chmod 755 /home/$USER_NAME/scripts/*
fi
