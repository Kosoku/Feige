#!/bin/sh

bundle exec jazzy --clean --author Kosoku --author_url http://kosoku.com/ --source-host github --source-host-url https://github.com/Kosoku/Feige --module-version $(./scripts/print_info_plist_key.sh "CFBundleShortVersionString") --build-tool-arguments -scheme,Feige --module Feige --root-url https://kosoku.github.io/Feige/ --output docs --theme fullwidth