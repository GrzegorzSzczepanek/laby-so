#!/bin/bash

#. Kasowanie wszystkich plików pustych (o zerowej wielkości) w zadanym katalogu (parametr
# wywołania skryptu). Skrypt powinien tworzyć w zadanym pliku (parametr) listę skasowanych
# plików. Nie powinien analizować dołączeń symbolicznych.

if [ $# -ne 2 ]; then
    echo "Usage: $0 <directory> <log_file>" >&2
    exit 1
fi

if [ ! -d "$1" ]; then
    echo "Error: '$1' katalog nie istenieje" >&2
    exit 1
fi

if [ ! -r "$1" ]; then
    echo "Error: Katalong '$1' nie jest readable." >&2
    exit 1
fi

log_dir=$(dirname "$2")
if [ ! -w "$log_dir" ]; then
    echo "Error: Nie można zapisac do '$2': katalog '$log_dir' nie jest writable." >&2
    exit 1
fi


> "$2" # zerujemy plik, ktory jest drugim orgumentem
for f in $1/*; do
    # -f czy plik istnieje, -L sprawdza czy to powiazanie symboliczne, -s sprawdza czy plik istnieje i jego zawartosc jest niezerewa
    if [ -f "$f" ] && [ ! -L "$f" ] && [ ! -s "$f" ]; then
        # to sie wykona jezeli mamy pusty plik nie będący powiązaniem symbolicznym
        echo "$f" >> "$2"
        rm "$f"
    fi
done

# Usuwa wszystkie puste pliki w katalogu, zapisując ich nazwy do osobnego pliku logu, ignorując dowiązania symboliczne
