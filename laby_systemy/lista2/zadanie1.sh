#!/bin/bash

# sprawdzamy ilosc argumentow, musi byc dokladnie 1 (katalog)
if [[ $# -ne 1 ]]; then
  echo "Nieprawidlowa liczba argumentow"
  echo "uzycie: $0 <katalog>"
  exit 1
fi

katalog=$1  

# sprawdzamy czy katalog istnieje, jesli nie to blad i exit
if [[ ! -d "$katalog" ]]; then
  echo "Katalog nie istnieje"
  exit 1
fi

# sprawdzamy czy katalog jest readable, jesli nie to blad i exit
if [[ ! -r "$katalog" ]]; then
  echo "Katalog '$katalog' nie jest readable" >&2
  exit 1
fi

# deklarujemy tablice asocjatywna. klucze to nr inode, a wartosci to oddzielone spacjami listy sciezek plikow z danym inode. grupujemy twarde linki do tych samych danych
declare -A grupy

# petla po wszystkich plikach w katalogu, bez rekurencji
for f in "$katalog"/*; do

  # if f to plik i nie jest symlinkiem
  if [ -f "$f" ] && [ ! -L "$f" ]; then

    # pobieramy nr inode za pomoca stat -c %i tak by byl tylko inode
    inode=$(stat -c %i -- "$f")
    grupy[$inode]+="$f "
  fi

done

# petla po kluczach tablicy (unikalne inode)
for inode in "${!grupy[@]}"; do
  # konwertujemy liste sciezek na tablice bashowa
  read -ra pliki <<< "${grupy[$inode]}"
  # jesli w grupie wiecej niz 1 plik, to sa twarde linki
  if [ ${#pliki[@]} -gt 1 ]; then
    min_nazwa=""
    min_plik=""
    # petla do znalezienia pliku z najmniejsza nazwa (leksykograficznie)
    for plik in "${pliki[@]}"; do
      nazwa=$(basename "$plik")
      # jesli pusta lub mniejsza niz aktualna min
      if [ -z "$min_nazwa" ] || [ "$nazwa" < "$min_nazwa" ]; then
        min_nazwa="$nazwa"
        min_plik="$plik"
      fi
    done
    # petla po plikach, konwertujemy te nie-min na symlinki
    for plik in "${pliki[@]}"; do
      if [ "$plik" != "$min_plik" ]; then
        # usuwamy stary plik (twardy link)
        rm -- "$plik"
        # tworzymy symlink wzgledny do min nazwy
        ln -s -- "$min_nazwa" "$plik"
      fi
    done
  fi
done


