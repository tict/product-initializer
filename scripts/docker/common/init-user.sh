#!/bin/sh
#
# Usage:
#   cp -r xxx/skel/home /tmp/home
#   DEV_USER_ID=501 DEV_GROUP_ID=501 ./user.sh 
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

if [ ! -e /tmp/home ]; then
    exit 0
fi

PI_SKEL_HOME=/opt/pi/skel/home
USER_NAME=`id -nu ${DEV_USER_ID}`
cp -fr $PI_SKEL_HOME/* /home/$USER_NAME/ \
    && (cp -f $PI_SKEL_HOME/.bashrc /home/$USER_NAME/.bashrc || echo "user default .bashrc") \
    && rm -fr $PI_SKEL_HOME
chown -R ${DEV_USER_ID}:${DEV_GROUP_ID} /home/$USER_NAME \
    && chmod 755 /home/$USER_NAME/scripts/*
