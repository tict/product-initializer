TARGET_ROOT :=
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

# test
test:
	echo $(SCRIPT_FILES_DOCKER_COMMON)


# prepare
.PHPNY: prepare-rust
prepare-rust: $(RUST_ROOT)/basic/.env dist


# .env
$(RUST_ROOT)/basic/.env: $(SCRIPT_FILES_DOCKER_COMMON)
	cp -r $(SCRIPTS_DOCKER_COMMON) `dirname $@`/docker/tool/scripts/common
	cp -r $(SCRIPTS_DOCKER_COMMON) `dirname $@`/docker/tool/skel/main/docker/develop/scripts/common
	sh scripts/basic/env.sh $@
	cp $@ `dirname $@`/docker/tool/skel/main


# rust
.PHONY: rust
rust: prepare-rust
	@make run TARGET_ROOT="$(RUST_ROOT)/basic"

.PHONY: rust-shell
rust-shell: prepare-rust
	@make run-shell TARGET_ROOT="$(RUST_ROOT)/basic"

# main
.PHONY: run
run:
	@cd $(TARGET_ROOT) \
	&& ($(DOCKER_COMPOSE) up && $(DOCKER_COMPOSE) rm -f tool || $(DOCKER_COMPOSE) rm -f tool)

# shell
.PHONY: run-shell
run-shell:
	@cd $(TARGET_ROOT) \
	&& ( \
		$(DOCKER_COMPOSE) run --entrypoint bash tool \
			&& $(DOCKER_COMPOSE) rm -f tool \
			|| $(DOCKER_COMPOSE) rm -f tool \
	)
