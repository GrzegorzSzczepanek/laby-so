#!/bin/bash
# skrypt_mockujacy.sh - tworzy przykladowe dane do testowania

if [[ $# -ne 1 ]]; then
  echo "Uzycie: $0 <katalog_testowy>"
  exit 1
fi

katalog_testowy=$1

# tworzymy katalog testowy jesli nie istnieje
if [[ ! -d "$katalog_testowy" ]]; then
  mkdir -p "$katalog_testowy" || { echo "Blad tworzenia katalogu"; exit 1; }
fi

# usuwamy stara zawartosc
rm -rf "$katalog_testowy"/*

echo "Tworzenie mockowych danych w '$katalog_testowy'..."

# tworzymy zwykle pliki bez dowiazan
echo "Plik bez dowiazan 1" > "$katalog_testowy/zwykly1.txt"
echo "Plik bez dowiazan 2" > "$katalog_testowy/zwykly2.txt"

# tworzymy plik bazowy i dowiazania twarde do niego
echo "Plik z dowiazaniami twardymi - grupa 1" > "$katalog_testowy/plik_bazowy1.txt"
ln "$katalog_testowy/plik_bazowy1.txt" "$katalog_testowy/hardlink1a.txt"
ln "$katalog_testowy/plik_bazowy1.txt" "$katalog_testowy/hardlink1b.txt"

# druga grupa dowiazan twardych
echo "Plik z dowiazaniami twardymi - grupa 2" > "$katalog_testowy/plik_bazowy2.txt"
ln "$katalog_testowy/plik_bazowy2.txt" "$katalog_testowy/hardlink2a.txt"
ln "$katalog_testowy/plik_bazowy2.txt" "$katalog_testowy/hardlink2b.txt"
ln "$katalog_testowy/plik_bazowy2.txt" "$katalog_testowy/hardlink2c.txt"

# trzecia grupa - tylko 2 dowiazania
echo "Plik z dowiazaniami twardymi - grupa 3" > "$katalog_testowy/plik_bazowy3.txt"
ln "$katalog_testowy/plik_bazowy3.txt" "$katalog_testowy/hardlink3a.txt"

# tworzymy dowiazanie symboliczne (powinno zostac nietykniete)
ln -s zwykly1.txt "$katalog_testowy/symlink_do_zwyklego.txt"

# tworzymy podkatalog (powinien zostac nietkniety)
mkdir "$katalog_testowy/podkatalog"
echo "Plik w podkatalogu" > "$katalog_testowy/podkatalog/plik.txt"

echo ""
echo "Mock danych utworzony!"
echo ""
echo "Stan PRZED uruchomieniem skryptu:"
echo "=================================="
ls -li "$katalog_testowy"
echo ""
echo "Aby uruchomić główny skrypt:"
echo "./skrypt_glowny.sh $katalog_testowy"
