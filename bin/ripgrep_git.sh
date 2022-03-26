#!/bin/bash
UNAME=`uname`
if [[ "$UNAME" == "MINGW"* ]]; then
    { rg --files --path-separator "//" --hidden; git ls-files; } | sort -u
else
    { rg --files --hidden; git ls-files; } | sort -u
fi

