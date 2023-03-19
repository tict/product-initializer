TARGET_ROOT :=
DOCKER_COMPOSE := docker-compose

RUST_ROOT := languages/rust

SCRIPTS_DOCKER_COMMON := scripts/docker/common

# clean
.PHONY: clean
clean:
	rm -fr dist
	@for P in `find languages -name .env -print`; do rm $${P}; echo "remove $${P}"; done
	@for P in `find languages -name common -print | grep scripts\/common`; do rm -fr $${P}; echo "remove $${P}"; done


# target dir
dist:
	mkdir -p dist


# prepare
.PHPNY: prepare-rust
prepare-rust: $(RUST_ROOT)/basic/.env dist


# .env
$(RUST_ROOT)/basic/.env: $(SCRIPTS_DOCKER_COMMON)/init-user.sh
	cp -r $(SCRIPTS_DOCKER_COMMON) `dirname $@`/docker/tool/scripts/common
	sh scripts/basic/env.sh $@


# rust
.PHONY: rust
rust: prepare-rust
	@make run TARGET_ROOT="$(RUST_ROOT)/basic"


# main
.PHONY: run
run:
	cd $(TARGET_ROOT) \
	&& ($(DOCKER_COMPOSE) up && $(DOCKER_COMPOSE) rm -f tool || $(DOCKER_COMPOSE) rm -f tool)
