#!/bin/sh

# diff is called by git with 7 parameters:
# path old-file old-hex old-mode new-file new-hex new-mode

#chdiff --wait "$2" "$5"
opendiff "$2" "$5" -merge "$1"
