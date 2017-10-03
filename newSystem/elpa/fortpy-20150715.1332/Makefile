ENV = env

VIRTUALENV_SYSTEM_SITE_PACKAGES ?= true
VIRTUALENV = \
	VIRTUALENV_SYSTEM_SITE_PACKAGES=$(VIRTUALENV_SYSTEM_SITE_PACKAGES) \
		virtualenv --python=$(PYTHON)
PIP_INSTALL = $(ENV)/$(BINDIR)/pip install

PYTHON ?= python
CASK ?= cask
export EMACS ?= emacs

BINDIR ?= bin

ELPA_DIR = \
	.cask/$(shell ${EMACS} -Q --batch --eval '(princ emacs-version)')/elpa
# See: cask-elpa-dir

VIRTUAL_EMACS = ${CASK} exec ${EMACS} -Q \
--eval "(setq python-environment--verbose t)" \
--eval "(setq fortpy:environment-root \"$(PWD)/$(ENV)\")"

.PHONY : tryout clean-elpa env clean-env clean \
	print-deps

compile: elpa clean-elc
	${VIRTUAL_EMACS} -batch \
		-L . -f batch-byte-compile *.el

clean-elc:
	rm -rf *.elc

tryout: compile env
	${VIRTUAL_EMACS} -L . -l tryout-fortpy.el

ensure-git:
	test -d .git  # Running task that can be run only in git repository

elpa: ${ELPA_DIR}
${ELPA_DIR}: Cask
	${CASK} install
	test -d $@
	touch $@

clean-elpa:
	rm -rf ${ELPA_DIR}

env: $(ENV)/$(BINDIR)/fortpyepcserver
$(ENV)/$(BINDIR)/fortpyepcserver: ${ELPA_DIR} fortpyepcserver.py setup.py
	${VIRTUAL_EMACS} -batch -l fortpy.el -f "fortpy:install-server-block"
	test -f $@

clean-env:
	rm -rf $(ENV)

clean-el: clean-elpa clean-elc
clean: clean-env clean-el
	rm -rf .cask

print-deps: elpa env
	@echo "----------------------- Dependencies -----------------------"
	$(EMACS) --version
	${VIRTUAL_EMACS} -batch -l fortpy.el -f fortpy:print-fortpy-version
	ls -d $(ENV)/*/python*/site-packages/*egg-info
	@echo "------------------------------------------------------------"


### Packaging
#
# Create dist/${PACKAGE}-${VERSION}.tar.gz ready for distribution.
#
# See: (info "(elisp) Multi-file Packages")
PACKAGE = fortpy
VERSION = $(shell grep ';; Version:' fortpy.el | sed 's/^.* \([0-9].*\)$$/\1/')
DIST_FILES = fortpy-pkg.el fortpy.el fortpyepcserver.py \
	Makefile tryout-fortpy.el

.PHONY: dist ${PACKAGE}-${VERSION}.tar.gz ${PACKAGE}-${VERSION} \
	clean-dist clean-dist-all

dist: clean-dist
	${MAKE} dist-1

dist-1: dist/${PACKAGE}-${VERSION}.tar dist/${PACKAGE}-${VERSION}.tar.gz

dist/${PACKAGE}-${VERSION}.tar: ${PACKAGE}-${VERSION}.tar
${PACKAGE}-${VERSION}.tar: ${PACKAGE}-${VERSION}
	tar --directory dist -cvf dist/$@ $<

dist/${PACKAGE}-${VERSION}.tar.gz: ${PACKAGE}-${VERSION}.tar.gz
${PACKAGE}-${VERSION}.tar.gz: ${PACKAGE}-${VERSION}
	tar --directory dist -cvzf dist/$@ $<

${PACKAGE}-${VERSION}: dist/${PACKAGE}-${VERSION}
dist/${PACKAGE}-${VERSION}:
	mkdir -p $@
	cp -v ${DIST_FILES} $@

clean-dist:
	rm -rf dist/${PACKAGE}-${VERSION}*

clean-dist-all:
	rm -rf dist



### Package installation
PACKAGE_USER_DIR =
TEST_PACKAGE_DIR = dist/test

install-dist:
	test -d '${PACKAGE_USER_DIR}'
	${EMACS} --batch -Q \
	-l package \
        --eval " \
        (add-to-list 'package-archives \
             '(\"marmalade\" . \"http://marmalade-repo.org/packages/\") t)" \
	--eval '(setq package-user-dir "${PWD}/${PACKAGE_USER_DIR}")' \
	--eval '(package-list-packages)' \
	--eval '(package-install-file "${PWD}/dist/${PACKAGE}-${VERSION}.tar")'

test-install: dist/${PACKAGE}-${VERSION}.tar
	rm -rf ${TEST_PACKAGE_DIR}
	mkdir -p ${TEST_PACKAGE_DIR}
	${MAKE} install-dist PACKAGE_USER_DIR=${TEST_PACKAGE_DIR}
