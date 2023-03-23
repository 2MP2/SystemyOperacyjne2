#!/bin/bash

DRC=${1}
echo "Podałeś katalog: ${DRC}"

if [[ -d ${DRC} ]]; then
    rm -rf ${DRC}
fi

mkdir ${DRC}

FILE=${2}

#cat wypisuje na ekran

NAMES=$(cat ${FILE})

COUNT = 0
#set -x #flaga do debagowania
for NAME in ${NAMES}; do

    # -lt = lower than -ne = not equal 
    if [[ $((COUNT % 2)) -eq 0 ]]; then
        touch ${DRC}/${NAME}
        echo "plik regularny ${NAME}"
    else
        mkdir ${DRC}/${NAME}
        echo "katalog ${DRC}/${NAME}"
    fi

    COUNT=$((COUNT + 1))
done