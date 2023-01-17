#!/bin/env bash

# Simple front end to iconv
# Requires 'bash' for extended 'type' command

entrydir="${PWD}"
echo "${PWD}: Input: $@" >>/tmp/iconv.$$.out

mydir=$(cd $(dirname $0) && echo $PWD)

alliconv=$(type -ap iconv)
realiconv=$(echo "${alliconv}" | tail -1)

parms=""
for p in $@; do
  if [ "$p" = "ISO-8859-1" ]; then
    modp="ISO8859-1"
  else
    modp=$p
  fi
  parms="${parms} ${modp}"
done
echo "Output: $parms" >>/tmp/iconv.$$.out
${realiconv} $parms >/tmp/iconv.$$
rc=$?
echo "rc: $rc" >>/tmp/iconv.$$.out
chtag -tcISO8859-1 /tmp/iconv.$$
cat /tmp/iconv.$$
exit $rc