## Stripped down version of devel-spam. Missing here:
##   lib, pkgdown, headers...
## to be uncommented:

## make update --always-make
## make dependencies (of not all packages work on R-99)
## make lib-testthat (github version of testthat)
## make tar
## make check

include Makefile.defs

NAME := GeneralizedWendland
VERSION := 0.5-0
MAINTAINER := Thomas Fischer
MAINTAINER_MAIL := thomascasparfischer@gmail.com

TARPACK = $(NAME)_$(VERSION).tar.gz

BUILDARGS =
CHECKARGS = --as-cran #--use-valgrind # --use-valgrind --use-gct
INSTALLARGS = ##--clean --build --library=./lib/ --byte-compile --no-lock
# --run-dontrun     do run \dontrun sections in the Rd files
# --run-donttest    do run \donttest sections in the Rd files
# --use-gctuse      'gctorture(TRUE)' when running examples/tests

## ----------------------------------------------------------------------------------

R_CHECK_ENVIRON:=check.Renviron

all: tar

archive:
	mv tar/$(NAME)_*.tar.gz archive/

update:
## only change the timestamps of this file if necessary
	if [ "Version: $(VERSION)" != "$(shell grep 'Version' GeneralizedWendland/DESCRIPTION)" ] ; then \
	$(MAKE) archive ; \
	cd GeneralizedWendland && sed -i -r -- 's/^Version:.*/Version: '$(VERSION)'/g' DESCRIPTION ; \
	fi
	if [ "Date: $(shell date +'%F')" != "$(shell grep 'Date' GeneralizedWendland/DESCRIPTION)" ] ; then \
	cd GeneralizedWendland && sed -i -r -- 's/^Date:.*/Date: '`date +'%F'`'/g' DESCRIPTION ; \
	fi

## 'tar' and 'install' --------------------------
tar: tar/$(TARPACK)

tar/$(TARPACK): $(shell find GeneralizedWendland -type f) Makefile
	$(MAKE) update
	mkdir -p tar
	cd tar &&  $(R) CMD build ../GeneralizedWendland

install: tar/$(TARPACK)
	$(RSCRIPT) -e "install.packages('tar/$(TARPACK)', repos=NULL, lib = '~/R/x86_64-pc-linux-gnu-library/4.2')"

## Check the package ------------------------------------
check: tar
	cd tar && R_CHECK_ENVIRON=$(R_CHECK_ENVIRON) $(R) CMD check $(CHECKARGS) $(TARPACK)

## winbuilder
check-win: update
	$(RSCRIPT) -e "devtools::check_win_release(pkg = \"GeneralizedWendland\")"

check-win-old: update
	$(RSCRIPT) -e "devtools::check_win_oldrelease(pkg = \"GeneralizedWendland\")"

check-win-devel: update
	$(RSCRIPT) -e "devtools::check_win_devel(pkg = \"GeneralizedWendland\")"


## test package -------------------------------------------
## run tests including skip_on_cran() tests
test-package:
	$(RSCRIPT) -e "library(\"GeneralizedWendland\", lib.loc = \"lib\"); devtools::test(\"GeneralizedWendland\")"

## run examples including "dontrun example"
test-examples:
	$(RSCRIPT) -e "library(\"GeneralizedWendland\", lib.loc = \"lib\"); library(\"fields\"); devtools::run_examples(\"GeneralizedWendland\", run = FALSE)"
	rm -f Rplots*.pdf


## test demos -------------------------------------------------
test-demos:
	rm -fr demoruns/demo
	cp -r GeneralizedWendland/demo demoruns/
	cd demoruns && $(RSCRIPT) --vanilla rundemos.R > rundemos.Rout

## vignettes
## ----------------------------------------------------------

vignette:
	cd vignettes && make all

## Cleanup
## ----------------------------------------------------------

clean:
	rm -f  Rplots*.pdf .RData .Rhistory .RData
	rm -rf tar/*.Rcheck
	cd vignettes && make clean
#	rm -f demoruns/*.pdf demoruns/*out
#	rm -fr demoruns/demo

cleanall:
	$(MAKE) clean
	rm -rf tar/*
	rm -rf GeneralizedWendland/src/*.o GeneralizedWendland/src/*.so
	cd vignettes && make cleanall


finalizer:
	cd tar && rm -rf GeneralizedWendland.Rcheck/
	cd tar && $(R) CMD check $(TARPACK)
	cp -uv tar/GeneralizedWendland.Rcheck/tests/*.Rout GeneralizedWendland/tests/.
	cd GeneralizedWendland/tests/ && rm -f *.Rout.save #&& rename -v '\.Rout' '\.Rout.save' *.Rout
	cd tar && $(R) CMD build ../GeneralizedWendland
	cp vignettes/GeneralizedWendland.pdf  GeneralizedWendland/vignettes
	cp vignettes/GeneralizedWendland.pdf.asis GeneralizedWendland/vignettes


## following section is not cleaned:
.PHONY: update tar install uninstall \
	check check-win check-win-devel \
	test-package test-examples \
	vignette \
  archive clean cleanall \
  finalizer


.SUFFIXES: .f .o
