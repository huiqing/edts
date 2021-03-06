MAKEFLAGS=-s

.PHONY: all
all:
	@-if [ -z "${EDTS_SKIP_SUBMODULE_UPDATE}" ]; \
	then git submodule update --init; fi
	@cd lib/edts && $(MAKE) MAKEFLAGS="$(MAKEFLAGS)"

.PHONY: clean
clean:
	rm -rfv elisp/*/*.elc
	@cd lib/edts && $(MAKE) MAKEFLAGS="$(MAKEFLAGS)" clean

.PHONY: ert
ert:
	emacs -q --no-splash --batch -l edts-start.el -f ert-run-tests-batch-and-exit

.PHONY: eunit
eunit:
	@(cd lib/edts; ./rebar eunit skip_deps=true)

.PHONY: ct
ct:
	@(cd lib/edts; ./rebar ct skip_deps=true)

.PHONY: test
test: all ert eunit ct
