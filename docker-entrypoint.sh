#!/bin/sh

if [ $# -eq 0 ]; then
  if [ ! -f goodlist.txt ]; then
    touch goodlist.txt
  fi
  go-proxycheck -treds=${JOBS} -url=${SITE} -in=goodlist.txt -out=proxy_new.txt -info
  mv proxy_new.txt ${DIR}/proxy.txt
else
  exec "$@"
fi
