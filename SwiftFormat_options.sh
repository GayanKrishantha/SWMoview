##!/bin/zsh
#
#echo 'Starting SwiftFormat'
#/usr/bin/xcrun --sdk macosx swift run swiftformat "../GO Sharing"

# format options
--allman true
--indent tabs
--elseposition next-line
--header " Copyright (c) {year} agostini.tech\nMasterminded by Meself."
--self init-only
