#!/bin/bash
# sprawdzamy ilosc argumentow, musi byc dokladnie 1 (katalog)
if [[ $# -ne 1 ]]; then
  echo "Nieprawidlowa liczba argumentow"
  echo "uzycie: $0 <katalog>"
  exit 1
fi

katalog=$1  

if [[ ! -d "$katalog" ]]; then
  echo "Katalog nie istnieje"
  exit 1
fi
if [[ ! -r "$katalog" ]]; then
  echo "Katalog '$katalog' nie jest readable" >&2
  exit 1
fi

if [[ ! -w "$katalog" ]]; then
  echo "Katalog '$katalog' nie jest writable" >&2
  exit 1
fi

for plik in "$katalog"/*; do
  # sprawdzamy czy plik istnieje (na wypadek pustego katalogu)
  if [[ ! -e "$plik" ]]; then
    continue
  fi
  
  # sprawdzamy czy to plik regularny
  if [[ ! -f "$plik" ]]; then
    continue
  fi
  
  # sprawdzamy czy to dowiazanie symboliczne (pomijamy je)
  if [[ -L "$plik" ]]; then
    continue
  fi
  
  # sprawdzamy liczbe dowiazan twardych
  liczba_dowiazan=$(stat -c %h "$plik" 2>/dev/null)
  
  # walidacja wyniku stat
  if [[ -z "$liczba_dowiazan" ]]; then
    echo "Blad odczytu liczby dowiazan dla '$plik'" >&2
    continue
  fi
  
  # jesli plik ma wiecej niz 1 dowiazanie twarde, zamieniamy na symboliczne
  if [[ "$liczba_dowiazan" -gt 1 ]]; then
    # zapisujemy inode pliku
    inode=$(stat -c %i "$plik" 2>/dev/null)
    
    if [[ -z "$inode" ]]; then
      echo "Blad odczytu inode dla '$plik'" >&2
      continue
    fi
    
    # szukamy pierwszego pliku z tym samym inode (bedzie celem dowiazania)
    cel=""
    for kandydat in "$katalog"/*; do
      if [[ -e "$kandydat" && ! -L "$kandydat" ]]; then
        inode_kandydata=$(stat -c %i "$kandydat" 2>/dev/null)
        if [[ "$inode_kandydata" == "$inode" && "$kandydat" != "$plik" ]]; then
          cel="$kandydat"
          break
        fi
      fi
    done
    
    # jesli znalezlismy cel, usuwamy plik i tworzymy dowiazanie symboliczne
    if [[ -n "$cel" ]]; then
      # tworzymy wzgledna sciezke
      nazwa_celu=$(basename "$cel")
      
      # usuwamy plik
      if ! rm "$plik" 2>/dev/null; then
        echo "Blad usuwania '$plik'" >&2
        continue
      fi
      
      # tworzymy dowiazanie symboliczne
      if ! ln -s "$nazwa_celu" "$plik" 2>/dev/null; then
        echo "Blad tworzenia dowiazania symbolicznego '$plik'" >&2
        continue
      fi
    fi
  fi
done

exit 0
