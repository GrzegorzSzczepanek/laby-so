#!/bin/bash
# Przenosi wszystkie pliki wykonywalne z jednego katalogu do drugiego, pozostawiając inne pliki i katalogi bez zmian.

# ne - not equal
if [ $# -ne 2 ]; then
  exit 1
fi

for f in $1/*; do
    if [ -f "$f" ] && [ -x "$f" ]; then
        mv "$f" "$2/"
    fi
done

