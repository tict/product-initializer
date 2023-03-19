FROM rust:latest

RUN apt-get update \
  && apt-get upgrade -y \
  && apt-get install -y -q \
  locales

ENV CARGO_TARGET_DIR=/tmp/target \
  DEBIAN_FRONTEND=noninteractive \
  LC_CTYPE=ja_JP.utf8 \
  LANG=ja_JP.utf8


RUN apt-get update \
  && apt-get upgrade -y \
  && apt-get install -y -q \
  locales \
  curl \
  wget

RUN apt-get clean \
  && rm -rf /var/lib/apt/lists/*

RUN rustup component add rls rust-analysis rust-src rustfmt clippy \
  && cargo install cargo-edit cargo-watch
