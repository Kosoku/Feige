#!/bin/sh

PLIST_BUDDY_PATH="/usr/libexec/PlistBuddy"
INFO_PLIST="Feige/Info.plist"

$PLIST_BUDDY_PATH -c "Set :$1 $2" $INFO_PLIST