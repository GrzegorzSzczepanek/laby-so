#!/bin/bash
if [ $# -ne 2 ]; then
    exit 1
fi
find "$1" -maxdepth $2 -type f -printf "%P/\n"

# Wyświetla listę plików z katalogu i jego podkatalogów do określonej głębokości zagnieżdżenia, podając ścieżki względne.

