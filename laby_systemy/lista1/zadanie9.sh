#!/bin/bash
if [ $# -ne 1 ]; then
    exit 1
fi

o=$(basename "$1") # wyciągamy nazwę pliku bez ścieżki katalogu
> "$o" # czyścimy lub truncatujemy plik by przygotowac go na nowy kontent

while IFS= read -r line; do # Internal Field Separator pozwala uniknac usuwania poprzedzajacych i nastepujacych whitespaces
    if [ -f "$line" ]; then
        echo "=== $line ===" >> "$o"
        cat "$line" >> "$o"
    fi
done < "$1"

# Łączy pliki wymienione w pliku listy w kolejności ich występowania na liście, dodając nagłówek z nazwą pliku, wynik zapisuje pod nazwą pliku listy.

