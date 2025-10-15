#!/bin/bash
# Usuwa najpierw wszystkie pliki z rozszerzeniem .old, a następnie zmienia nazwy plików z prawem odczytu i zapisu, dodając im to rozszerzenie.
if [ $# -ne 1 ]; then
    exit 1
fi
rm -f $1/*.old
for f in $1/*; do
    if [ -f "$f" ] && [ -r "$f" ] && [ -w "$f" ]; then
        mv "$f" "$f.old"
    fi
done

