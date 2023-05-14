#!/bin/bash -eu

# a) Zamiana $HEADER$ na /temat/ we wszystkich plikach z rozszerzeniem .groovy w katalogu 'groovies'
sed -i 's/\$HEADER\$/\/temat\//g' groovies/*.groovy

# b) Po każdej linijce z 'class' w plikach z rozszerzeniem .groovy w katalogu 'groovies' dodaj 'String marker = '/!@$%/''
sed -i '/class/ a String marker = '\''\/!@\$%\/'\'';' groovies/*.groovy
