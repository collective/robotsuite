help:
	@grep -Eh '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' | uniq

RF ?= 3.1.2
ROBOT ?= rf$(subst .,,$(RF))
PYTHON ?= python39

.PHONY: clean
clean:  ## Clean up build artifacts
	rm -rf .installed.cfg bin eggs parts devenv.local.nix

.PHONY: show
show:  ## Show installed packages
	pip list
	buildout -N annotate versions
	@python -c "from importlib import metadata; print('\n'.join(sorted(d.metadata['Name'] + f'=={d.version}' for d in metadata.distributions() if d.metadata['Name'].lower() in ['robotframework'])))"

.PHONY: test
test: ./bin/test  ## Run tests
	bin/test

.PHONY: devenv-%
devenv-%: devenv.local.nix
	devenv shell $(MAKE) $*

shell: devenv.local.nix  ## Start a shell with the development environment
	devenv shell

###

bin/test: buildout.cfg
	buildout -N

.PHONY: test\ all
test\ all:  ## Test all supported versions
	make PYTHON=python39 RF=3.0.4 clean devenv-test
	make PYTHON=python39 RF=3.1.2 clean devenv-test
	make PYTHON=python39 RF=3.2.2 clean devenv-test
	make PYTHON=python39 RF=4.0.3 clean devenv-test
	make PYTHON=python39 RF=4.1.3 clean devenv-test
	make PYTHON=python39 RF=5.0.1 clean devenv-test
	make PYTHON=python39 RF=6.0.2 clean devenv-test
	make PYTHON=python39 RF=6.1.1 clean devenv-test
	make PYTHON=python39 RF=7.0.1 clean devenv-test
	make PYTHON=python39 RF=7.1.1 clean devenv-test
	make PYTHON=python39 RF=7.2.2 clean devenv-test

	make PYTHON=python310 RF=3.2.2 clean devenv-test
	make PYTHON=python310 RF=4.0.3 clean devenv-test
	make PYTHON=python310 RF=4.1.3 clean devenv-test
	make PYTHON=python310 RF=5.0.1 clean devenv-test
	make PYTHON=python310 RF=6.0.2 clean devenv-test
	make PYTHON=python310 RF=6.1.1 clean devenv-test
	make PYTHON=python310 RF=7.0.1 clean devenv-test
	make PYTHON=python310 RF=7.1.1 clean devenv-test
	make PYTHON=python310 RF=7.2.2 clean devenv-test

	make PYTHON=python311 RF=3.2.2 clean devenv-test
	make PYTHON=python311 RF=4.0.3 clean devenv-test
	make PYTHON=python311 RF=4.1.3 clean devenv-test
	make PYTHON=python311 RF=5.0.1 clean devenv-test
	make PYTHON=python311 RF=6.0.2 clean devenv-test
	make PYTHON=python311 RF=6.1.1 clean devenv-test
	make PYTHON=python311 RF=7.0.1 clean devenv-test
	make PYTHON=python311 RF=7.1.1 clean devenv-test
	make PYTHON=python311 RF=7.2.2 clean devenv-test

	make PYTHON=python312 RF=3.2.2 clean devenv-test
	make PYTHON=python312 RF=4.0.3 clean devenv-test
	make PYTHON=python312 RF=4.1.3 clean devenv-test
	make PYTHON=python312 RF=5.0.1 clean devenv-test
	make PYTHON=python312 RF=6.0.2 clean devenv-test
	make PYTHON=python312 RF=6.1.1 clean devenv-test
	make PYTHON=python312 RF=7.0.1 clean devenv-test
	make PYTHON=python312 RF=7.1.1 clean devenv-test
	make PYTHON=python312 RF=7.2.2 clean devenv-test

uv.lock:
	uv lock
	sed -i 's| or (extra[^"]*||g' uv.lock
	# In addition, all robotframework deps must be removed from uv.lock package.metadata 

devenv.local.nix:
	@echo '{ pkgs, ...}: { cachix.push = "datakurre"; languages.python = { interpreter = pkgs.$(PYTHON); dependencies = [ "$(ROBOT)" "dev" ]; }; }' > devenv.local.nix
