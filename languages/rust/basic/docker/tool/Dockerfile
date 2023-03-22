FROM rust:latest

ARG DEV_USER_ID=${DEV_USER_ID}
ARG DEV_GROUP_ID=${DEV_GROUP_ID}
ARG PI=/opt/pi
ENV CARGO_TARGET_DIR=/tmp/target


COPY scripts ${PI}/scripts
COPY skel ${PI}/skel
RUN chmod -R 777 ${PI}/scripts
RUN DEV_USER_ID=${DEV_USER_ID} DEV_GROUP_ID=${DEV_GROUP_ID} sh /opt/pi/scripts/common/init-user.sh
