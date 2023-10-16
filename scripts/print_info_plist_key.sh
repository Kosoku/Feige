#!/bin/sh

PLIST_BUDDY_PATH="/usr/libexec/PlistBuddy"
INFO_PLIST="Feige/Info.plist"

$PLIST_BUDDY_PATH -c "Print :$1" $INFO_PLIST