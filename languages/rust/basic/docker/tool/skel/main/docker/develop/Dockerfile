FROM rust:latest

ARG DEV_USER_ID=${DEV_USER_ID}
ARG DEV_GROUP_ID=${DEV_GROUP_ID}
ARG PI=/opt/pi

RUN apt-get update \
  && apt-get upgrade -y \
  && apt-get install -y -q \
  locales \
  curl \
  less \
  screen \
  sudo

ENV CARGO_TARGET_DIR=/tmp/target \
  LC_CTYPE=ja_JP.utf8 \
  LANG=ja_JP.utf8


# User
COPY scripts ${PI}/scripts
RUN chmod -R 777 ${PI}
RUN DEV_USER_ID=${DEV_USER_ID} DEV_GROUP_ID=${DEV_GROUP_ID} sh /opt/pi/scripts/common/init-user.sh
RUN rm -fr ${PI}/scripts/common \
  && rm -f ${PI}/scripts/.gitignore


# Rust
RUN rustup component add clippy rls rust-analysis rust-src rust-docs rustfmt rust-analyzer
RUN cargo install cargo-edit cargo-watch

RUN apt-get clean \
  && rm -rf /var/lib/apt/lists/*
