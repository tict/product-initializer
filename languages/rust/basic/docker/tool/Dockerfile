FROM rust:latest

ARG DEV_USER_ID=${DEV_USER_ID}
ARG DEV_GROUP_ID=${DEV_GROUP_ID}
ENV CARGO_TARGET_DIR=/tmp/target


COPY scripts /opt/pi/scripts
COPY skel /opt/pi/skel
RUN chmod -R 777 /opt/pi
RUN DEV_USER_ID=${DEV_USER_ID} DEV_GROUP_ID=${DEV_GROUP_ID} sh /opt/pi/scripts/common/init-user.sh
