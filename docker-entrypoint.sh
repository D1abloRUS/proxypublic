#!/bin/sh

if [ $# -eq 0 ]; then
  if [ ! -f good_list.txt ]; then
    touch good_list.txt
  elif [ ! -f proxy_new.txt ]; then
    touch proxy_new.txt
  fi
  parallel -j${JOBS} "proxy_check.sh {}" <good_list.txt
  mv proxy_new.txt ${DIR}/proxy.txt
else
  exec "$@"
fi
