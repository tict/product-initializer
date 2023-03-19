FROM rust:latest

ARG DEV_USER_ID=${DEV_USER_ID}
ARG DEV_GROUP_ID=${DEV_GROUP_ID}

RUN apt-get update \
  && apt-get upgrade -y \
  && apt-get install -y -q \
  locales \
  curl \
  sudo \
  less

ENV CARGO_TARGET_DIR=/tmp/target \
  LC_CTYPE=ja_JP.utf8 \
  LANG=ja_JP.utf8

# User
COPY scripts /opt/pi/scripts
COPY skel /opt/pi/skel
RUN chmod -R 777 /opt/pi
RUN DEV_USER_ID=${DEV_USER_ID} DEV_GROUP_ID=${DEV_GROUP_ID} sh /opt/pi/scripts/common/init-user.sh


RUN apt-get clean \
  && rm -rf /var/lib/apt/lists/*

RUN rustup component add rls rust-analysis rust-src rustfmt clippy \
  && cargo install cargo-edit cargo-watch
