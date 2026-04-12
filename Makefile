SHELL := /usr/bin/env bash

.PHONY: build run smoke clean

build:
	./tools/build.sh

run:
	./tools/run.sh

smoke:
	./tools/smoke-test.sh

clean:
	rm -f build/snake64.prg build/snake64.d64
