RF ?= 3.1.2
ROBOT ?= rf$(subst .,,$(RF))
PYTHON ?= python39
ARGSTR ?= --argstr python $(PYTHON) --argstr robot $(ROBOT)

CACHIX_CACHE ?= datakurre

.PHONY: all
all: test

.PHONY: clean
clean:
	rm -rf .installed.cfg bin

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

.PHONY: nix
nix:
	make PYTHON=python27 RF=2.8.2 requirements
	make PYTHON=python27 RF=2.8.7 requirements
	make PYTHON=python27 RF=2.9.2 requirements
	make PYTHON=python27 RF=3.0.4 requirements
	make PYTHON=python27 RF=3.1.2 requirements
	make PYTHON=python27 RF=3.2.2 requirements
	make PYTHON=python27 RF=4.0.3 requirements
	make PYTHON=python27 RF=4.1.3 requirements

	make PYTHON=python36 RF=3.0.4 requirements
	make PYTHON=python36 RF=3.1.2 requirements
	make PYTHON=python36 RF=3.2.2 requirements
	make PYTHON=python36 RF=4.0.3 requirements
	make PYTHON=python36 RF=4.1.3 requirements
	make PYTHON=python36 RF=5.0.0 requirements

	make PYTHON=python37 RF=3.0.4 requirements
	make PYTHON=python37 RF=3.1.2 requirements
	make PYTHON=python37 RF=3.2.2 requirements
	make PYTHON=python37 RF=4.0.3 requirements
	make PYTHON=python37 RF=4.1.3 requirements
	make PYTHON=python37 RF=5.0.0 requirements

	make PYTHON=python38 RF=3.0.4 requirements
	make PYTHON=python38 RF=3.1.2 requirements
	make PYTHON=python38 RF=3.2.2 requirements
	make PYTHON=python38 RF=4.0.3 requirements
	make PYTHON=python38 RF=4.1.3 requirements
	make PYTHON=python38 RF=5.0.0 requirements

	make PYTHON=python39 RF=3.0.4 requirements
	make PYTHON=python39 RF=3.1.2 requirements
	make PYTHON=python39 RF=3.2.2 requirements
	make PYTHON=python39 RF=4.0.3 requirements
	make PYTHON=python39 RF=4.1.3 requirements
	make PYTHON=python39 RF=5.0.0 requirements

.PHONY: test-all
test-all:
	make PYTHON=python27 RF=2.8.2 clean nix-test
	make PYTHON=python27 RF=2.8.7 clean nix-test
	make PYTHON=python27 RF=2.9.2 clean nix-test
	make PYTHON=python27 RF=3.0.4 clean nix-test
	make PYTHON=python27 RF=3.1.2 clean nix-test
	make PYTHON=python27 RF=3.2.2 clean nix-test
	make PYTHON=python27 RF=4.0.3 clean nix-test
	make PYTHON=python27 RF=4.1.3 clean nix-test

	make python=python36 rf=3.0.4 clean nix-test
	make PYTHON=python36 RF=3.1.2 clean nix-test
	make PYTHON=python36 RF=3.2.2 clean nix-test
	make PYTHON=python36 RF=4.0.3 clean nix-test
	make PYTHON=python36 RF=4.1.3 clean nix-test
	make PYTHON=python36 RF=5.0.0 clean nix-test

	make PYTHON=python37 RF=3.0.4 clean nix-test
	make PYTHON=python37 RF=3.1.2 clean nix-test
	make PYTHON=python37 RF=3.2.2 clean nix-test
	make PYTHON=python37 RF=4.0.3 clean nix-test
	make PYTHON=python37 RF=4.1.3 clean nix-test
	make PYTHON=python37 RF=5.0.0 clean nix-test

	make PYTHON=python38 RF=3.0.4 clean nix-test
	make PYTHON=python38 RF=3.1.2 clean nix-test
	make PYTHON=python38 RF=3.2.2 clean nix-test
	make PYTHON=python38 RF=4.0.3 clean nix-test
	make PYTHON=python38 RF=4.1.3 clean nix-test
	make PYTHON=python38 RF=5.0.0 clean nix-test

	make PYTHON=python39 RF=3.0.4 clean nix-test
	make PYTHON=python39 RF=3.1.2 clean nix-test
	make PYTHON=python39 RF=3.2.2 clean nix-test
	make PYTHON=python39 RF=4.0.3 clean nix-test
	make PYTHON=python39 RF=4.1.3 clean nix-test
	make PYTHON=python39 RF=5.0.0 clean nix-test

.PHONY: test-all
cache-all:
	make PYTHON=python27 RF=2.8.2 cache
	make PYTHON=python27 RF=2.8.7 cache
	make PYTHON=python27 RF=2.9.2 cache
	make PYTHON=python27 RF=3.0.4 cache
	make PYTHON=python27 RF=3.1.2 cache
	make PYTHON=python27 RF=3.2.2 cache
	make PYTHON=python27 RF=4.0.3 cache
	make PYTHON=python27 RF=4.1.3 cache

	make python=python36 rf=3.0.4 cache
	make PYTHON=python36 RF=3.1.2 cache
	make PYTHON=python36 RF=3.2.2 cache
	make PYTHON=python36 RF=4.0.3 cache
	make PYTHON=python36 RF=4.1.3 cache
	make PYTHON=python36 RF=5.0.0 cache

	make PYTHON=python37 RF=3.0.4 cache
	make PYTHON=python37 RF=3.1.2 cache
	make PYTHON=python37 RF=3.2.2 cache
	make PYTHON=python37 RF=4.0.3 cache
	make PYTHON=python37 RF=4.1.3 cache
	make PYTHON=python37 RF=5.0.0 cache

	make PYTHON=python38 RF=3.0.4 cache
	make PYTHON=python38 RF=3.1.2 cache
	make PYTHON=python38 RF=3.2.2 cache
	make PYTHON=python38 RF=4.0.3 cache
	make PYTHON=python38 RF=4.1.3 cache
	make PYTHON=python38 RF=5.0.0 cache

	make PYTHON=python39 RF=3.0.4 cache
	make PYTHON=python39 RF=3.1.2 cache
	make PYTHON=python39 RF=3.2.2 cache
	make PYTHON=python39 RF=4.0.3 cache
	make PYTHON=python39 RF=4.1.3 cache
	make PYTHON=python39 RF=5.0.0 cache
