.PHONY: help build-frontend run-backend check test api-test verify verify-all clean

help:
	@echo "Targets:"
	@echo "  make build-frontend  Build frontend JS bundle"
	@echo "  make run-backend     Run backend server on 127.0.0.1:8080"
	@echo "  make check           Run moon check for all targets"
	@echo "  make test            Run moon test for all targets"
	@echo "  make api-test        Run Hurl API tests against local backend"
	@echo "  make verify          Run check + test"
	@echo "  make verify-all      Run verify + api-test"
	@echo "  make clean           Remove build artifacts"

build-frontend:
	moon build frontend --target js

run-backend:
	moon run backend --target native

check:
	moon check --deny-warn --target all

test:
	moon test --deny-warn --target all

api-test: build-frontend
	@command -v hurl >/dev/null 2>&1 || { echo "hurl is required for api-test"; exit 1; }
	@set -eu; \
		moon run backend --target native >/tmp/fullstack-one-project-backend.log 2>&1 & \
		pid=$$!; \
		trap 'kill $$pid >/dev/null 2>&1 || true' EXIT INT TERM; \
		sleep 1; \
		hurl --test backend/api.hurl

verify: check test

verify-all: verify api-test

clean:
	rm -rf _build
