#!/bin/bash

# a) Wypisz osoby o nieparzystym ID
echo "a) Osoby o nieparzystym ID:"
cat yolo.csv | grep -E "^[0-9]*[13579]," 1>&2


# b) wyodrębnienie wierszy z wartością $2.99 lub $5.99 lub $9.99
rows=$(grep -E ',(\$2\.99|\$5\.99|\$9\.99)[A-Z]*$' yolo.csv)

# wypisanie nazwisk i wartości na stderr
echo "$rows" | cut -d ',' -f 3,7 >&2

