REDOX=redox.img
REDOX_SOURCE=redox/build/x86_64/desktop/harddrive.img

all: $(REDOX)

$(REDOX): $(REDOX_SOURCE)
	cp $^ $@

$(REDOX_SOURCE):
	make all -C redox

# Prepare a development environment on Docker and enter it.
# Usage: $ make docker
docker:
	make -C .docker

# Delete a development environment on Docker.
# Usage: $ make clean_docker
clean_docker:
	make clean -C .docker

# Delete a development environment on Docker and Prepare a new one and enter it.
# Usage: $ make rebuild_docker
rebuild_docker:
	make rebuild -C .docker

# Get permission to develop RedoxEnv.
# Only developers can execute it and users don't have to do it.
# Usage: $ make permission GITHUB=<A path of ssh key to push to github.com> GITGPG=<A path of .gnupg directory to verify git commitment> CRATESIO=<A path of API key to log in crates.io>
permission:
	make permission -C .docker GITHUB=$(realpath $(GITHUB)) GITGPG=$(realpath $(GITGPG)) CRATESIO=$(realpath $(CRATESIO))

run: $(REDOX)
	make run -C .tmux

stop:
	make stop -C .tmux

debug: $(REDOX) stop
	make debug -C .tmux

