# Rust project

## Requirements

docker: ENGINE 20.x or greater
docker-compose: supporting 3.8


## How to run

### shell

```bash
docker-compose run --entrypoint bash --rm develop
```

You can use cargo command in the container.

```bash
    # run
    cargo run

    # others
    cargo check
    cargo build
    cargo test

    # version
    cargo --version
```

To shutdown docker

```bash
docker-compose down
```


## Update rust

```bash
docker-compose down --rmi all
docker-compose build --no-cache
```
