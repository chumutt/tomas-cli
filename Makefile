LISP ?= ros -Q run

all: test

run:
	rlwrap $(LISP) --load run.lisp

build:
	$(LISP)	--non-interactive \
		--load tomas-cli.asd \
		--eval '(ql:quickload :tomas-cli)' \
		--eval '(asdf:make :tomas-cli)'

test:
	$(LISP) --non-interactive \
		--load run-tests.lisp
