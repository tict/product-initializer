# set at internal make command run-xxxx
TARGET_ROOT :=
# docker compose
DOCKER_COMPOSE := docker-compose

RUST_ROOT := languages/rust

SCRIPTS_DOCKER_COMMON := scripts/docker/common
SCRIPT_FILES_DOCKER_COMMON := $(shell find $(SCRIPTS_DOCKER_COMMON) -name *.sh -print)

# clean
.PHONY: clean
clean:
	rm -fr dist
	@for P in `find languages -name .env -print`; do rm $${P}; echo "remove $${P}"; done
	@for P in `find languages -name common -print | grep scripts\/common`; do rm -fr $${P}; echo "remove $${P}"; done


# target dir
dist:
	mkdir -p dist


# rust
.PHONY: rust
rust:
	@make run TARGET_ROOT="$(RUST_ROOT)/basic"

.PHONY: rust-shell
rust-shell:
	@make run-shell TARGET_ROOT="$(RUST_ROOT)/basic"

.PHONY: rust-build
rust-build:
	@make run-build TARGET_ROOT="$(RUST_ROOT)/basic"

.PHONY: rust-prepare
rust-prepare:
	@make run-prepare TARGET_ROOT="$(RUST_ROOT)/basic"


# main
.PHONY: run
run: run-prepare
	@cd $(TARGET_ROOT) \
		&& ($(DOCKER_COMPOSE) up &&  $(DOCKER_COMPOSE) down --rmi all || $(DOCKER_COMPOSE) down --rmi all)

# shell
.PHONY: run-shell
run-shell: run-prepare
	@cd $(TARGET_ROOT) \
		&& $(DOCKER_COMPOSE) run --entrypoint bash --rm tool \
		&& $(DOCKER_COMPOSE) down --rmi all || $(DOCKER_COMPOSE) down --rmi all

# build image only
.PHONY: run-build
run-build: run-prepare
	@cd $(TARGET_ROOT) \
		&& $(DOCKER_COMPOSE) build --progress=plain

# prepare
.PHONY: run-prepare
run-prepare: $(TARGET_ROOT)/.env dist

# .env scripts skel
$(TARGET_ROOT)/.env: $(SCRIPT_FILES_DOCKER_COMMON)
	cp -r $(SCRIPTS_DOCKER_COMMON) `dirname $@`/docker/tool/scripts/common
	cp -r $(SCRIPTS_DOCKER_COMMON) `dirname $@`/docker/tool/skel/main/docker/develop/scripts/common
	sh scripts/basic/env.sh $@
	cp $@ `dirname $@`/docker/tool/skel/main
