#!/bin/sh

if [ $# -eq 0 ]; then
  if [ ! -f good_list.txt ]; then
    touch good_list.txt
  fi
  go-proxycheck -treds=${JOBS} -url=${SITE} -in=goodlist.txt -out=proxy_new.txt -info
  mv proxy_new.txt ${DIR}/proxy.txt
else
  exec "$@"
fi
