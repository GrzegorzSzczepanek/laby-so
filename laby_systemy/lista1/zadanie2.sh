#!/bin/bash

# Przesuwanie wszystkich plików z ustawionym prawem wykonywania z jednego katalogu do
# drugiego. Pozostałe pliki w katalogu nie powinny być ruszane. Również katalogi nie są
# przenoszone. Nazwy katalogów, źródłowego i docelowego, zadawane jako parametry skryptu.

# ne - not equal
if [ $# -ne 2 ]; then
  echo "Nieprawidlowa liczba argumentow"
  echo "uzycie: $0 <katalog> <katalog>"
  exit 1
fi

katalog1=$1
katalog2=$2

if [[ ! -d "$katalog1" ]]; then
  echo "Katalog nie istnieje"
  exit 1
fi

if [[ ! -d "$katalog2t" ]]; then
  echo "Katalog nie istnieje"
  exit 1
fi



for f in $1/*; do
    if [ -f "$f" ] && [ -x "$f" ]; then
        mv "$f" "$2/"
    fi
done

