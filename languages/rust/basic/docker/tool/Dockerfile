FROM rust:latest

ARG DEV_USER_ID=${DEV_USER_ID}
ARG DEV_GROUP_ID=${DEV_GROUP_ID}
ENV CARGO_TARGET_DIR=/tmp/target


COPY scripts /tmp/scripts
RUN DEV_USER_ID=${DEV_USER_ID} DEV_GROUP_ID=${DEV_GROUP_ID} sh /tmp/scripts/common/init-user.sh \
  && rm -fr /tmp/scripts

