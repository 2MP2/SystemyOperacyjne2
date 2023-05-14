#!/bin/bash -eu

# b) Znajdź zapytania, które mają frazę "denied" w linku
echo "b) Zapytania z frazą \"denied\" w linku:"
grep "denied" access_log

# c) Znajdź zapytania wysłane z IP: 64.242.88.10
echo "c) Zapytania wysłane z IP: 64.242.88.10:"
grep "64.242.88.10" access_log

# d) Znajdź zapytania NIEWYSŁANE z adresu IP tylko z FQDN
echo "d) Zapytania NIEWYSŁANE z adresu IP tylko z FQDN:"
grep -Ev "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b" access_log

# e) Znajdź unikalne zapytania typu DELETE
echo "e) Unikalne zapytania typu DELETE:"
grep -oE "\"DELETE .*\"" access_log | sort | uniq
