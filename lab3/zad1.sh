#!/bin/bash

set -eu

PRINT_DIR=${1}
TARGET_DIR=${2}

if [[ ! -d ${PRINT_DIR} ]]; then
    echo "${PRINT_DIR} does not exist"
    exit 1 
fi

if [[ ! -d ${TARGET_DIR} ]]; then
    echo "${TARGET_DIR} does not exist"
    exit 1 
fi

#symbolic link do not work

cd ${PRINT_DIR}
for FILE in $(ls); do
    if [[ -d ${FILE} ]]; then
        echo "${FILE} is director"
        FILE_PATH="${PRINT_DIR}/${FILE}"
        FILENAME_TOUP=$(echo "${FILE%.*}" | tr '[:lower:]' '[:upper:]')
        EXTENSION="${FILE##*.}"
        SYMLINK_NAME="${FILENAME_TOUP}_ln.${EXTENSION}"
        SYM_PATH="${TARGET_DIR}/${SYMLINK_NAME}"

        ln -s "../${FILE_PATH} ${SYM_PATH}"
    elif [[ -L ${FILE} ]]; then
        echo "${FILE} is symbolic link"
    elif [[ -f ${FILE} ]]; then
        echo "${FILE} regular file"

    fi
done 

