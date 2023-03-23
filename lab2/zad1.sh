#!/bin/bash

# Set default values
SOURCE_DIR=${1:-lab_uno}
RM_LIST=${2:-2remove}
TARGET_DIR=${3:-bakap}

# Create TARGET_DIR if it doesn't exist
if [[ ! -d "${TARGET_DIR}" ]]; then
  mkdir "${TARGET_DIR}"
fi

# Loop over RM_LIST file
FILES=$(cat ${RM_LIST})

for FILE in ${FILES}; do
  if [[ -f "${SOURCE_DIR}/${FILE}" ]]; then #if on RM_LIST
    rm "${SOURCE_DIR}/${FILE}"
  fi
done

# Move remaining files to TARGET_DIR
shopt -s nullglob #if SOURCE_DIR is not empty

for FILE in "${SOURCE_DIR}"/*; do
  if [[ -f "${FILE}" ]]; then
    mv "${FILE}" "${TARGET_DIR}"
  elif [[ -d "${FILE}" ]]; then
    cp -r "${FILE}" "${TARGET_DIR}"
  fi
done

# Check if there are any files remaining in SOURCE_DIR
NUMBER=0
for file in "${SOURCE_DIR}"/*; do
  if [[ -e "$file" ]]; then
    ((NUMBER++))
  fi
done


if [[ "${NUMBER}" -gt 0 ]]; then
  echo "jeszcze coś zostało"
  if [[ "${NUMBER}" -ge 2 ]]; then
    echo "zostały co najmniej 2 pliki"
  fi
  if [[ "${NUMBER}" -gt 4 ]]; then
    echo "zostało więcej niż 4 pliki"
  elif [[ "${NUMBER}" -ge 2 ]]; then
    echo "zostały co najmniej 2 pliki"
  fi
else
  echo "tu był Kononowicz"
fi

# Archive TARGET_DIR
date=$(date +%F)
zip -r "bakap_${date}.zip" "${TARGET_DIR}"

