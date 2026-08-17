#!/usr/bin/env bash

for f in **/*.sh; do
	chmod +x "$f"
	shfmt -i 2 -ci -w "$f"
	shellcheck "$f" -e 1090,1091
done
