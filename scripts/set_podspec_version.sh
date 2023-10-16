#!/bin/sh

PODSPEC="Feige.podspec"

sed -i "" "s/\(s.version = '\).*\('\)/\1$1\2/" $PODSPEC