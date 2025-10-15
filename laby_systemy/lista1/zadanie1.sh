#!/bin/bash


# ne - not equal
if [ $# -ne 2 ]; then
  echo "Nieprawidlowa liczba argumentow"
  echo "uzycie: $0 <katalog> <rozszerzenie>"
  exit 1
fi

katalog=$1
rozszerzenie=$2

if [[ ! -d "$katalog" ]]; then
  echo "Katalog nie istnieje"
  exit 1
fi

for plik in "$katalog"/*."$rozszerzenie"; do
  if [[ -f "$plik" ]]; then
    echo "######$plik#######"
    cat "$plik" 
    echo ""
  fi

done
