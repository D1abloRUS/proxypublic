#!/bin/sh

PROXY=${1}

IP=$(echo ${PROXY} | sed 's/:.*//')
STATUS=$(curl --max-time 2 -s -x ${PROXY} -o /dev/null -w '%{http_code}' ${SITE})
CHECK_IN_LIST=$(cat proxy_new.txt | grep ${IP} 2>/dev/null)
if [ -z "$CHECK_IN_LIST" ]; then
  if [ ${STATUS} -eq 200 ]; then
    RESPONE=$(curl --max-time 2 -s -x ${PROXY} -o /dev/null -w '%{time_total}'\\n ${SITE} | sed 's/...$//g')
    COUNTRY=$(geoiplookup ${IP} | sed -nr 's/.*: (.*),.*/\1/p')
    echo "GOOD: ${PROXY};${COUNTRY};${RESPONE}"
    echo "${PROXY};${COUNTRY};${RESPONE}" >> proxy_new.txt
  fi
fi
