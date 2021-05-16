RF ?= 3.1.2
ROBOT ?= rf$(subst .,,$(RF))
PYTHON ?= python39
ARGSTR ?= --argstr python $(PYTHON) --argstr robot $(ROBOT)

CACHIX_CACHE ?= datakurre

.PHONY: all
all: test

.PHONY: show
show:
	pip list
	buildout -N annotate versions

.PHONY: test
test: ./bin/test
	bin/test

.PHONY: nix-%
nix-%:
	nix-shell setup.nix $(ARGSTR) -A package --run "$(MAKE) $*"

nix-env:
	nix-build setup.nix $(ARGSTR) -A env

nix-shell:
	nix-shell setup.nix $(ARGSTR) -A package

.PHONY: cache
cache:
	nix-store --query --references $$(nix-instantiate default.nix $(ARGSTR)) | \
	xargs nix-store --realise | xargs nix-store --query --requisites | cachix push $(CACHIX_CACHE)

###

.cache:
	mkdir -p .cache
	if [ -d ~/.cache/pip ]; then ln -s ~/.cache/pip ./.cache; fi

bin/test: buildout.cfg
	buildout -N

.PHONY: requirements
requirements: .cache ./nix/requirements-$(PYTHON)-$(ROBOT).nix

./nix/requirements-$(PYTHON)-$(ROBOT).nix: .cache requirements-$(PYTHON)-$(ROBOT).txt
	nix-shell -p "(import ./nix {}).pip2nix.$(PYTHON)" --run "pip2nix generate -r requirements-$(PYTHON)-$(ROBOT).txt --output=./nix/requirements-$(PYTHON)-$(ROBOT).nix"

requirements-$(PYTHON)-$(ROBOT).txt: .cache requirements.txt
	nix-shell -p "(import ./nix {}).pip2nix.$(PYTHON)" --run "pip2nix generate -r requirements.txt robotframework==$(RF) --output=./nix/requirements-$(PYTHON)-$(ROBOT).nix"
	@grep "pname =\|version =" ./nix/requirements-$(PYTHON)-$(ROBOT).nix|awk "ORS=NR%2?FS:RS"|sed 's|.*"\(.*\)";.*version = "\(.*\)".*|\1==\2|' > requirements-$(PYTHON)-$(ROBOT).txt
