#!/bin/bash
ROOT=$( cd "$(dirname "$0")/.." ; pwd -P )
cd ${ROOT}

ret=0
for fn in $(find . -not -path './vendor/*' -name '*.go' ); do
  if [[ $fn == *.pb.go ]];then
    continue
  fi
  head -20 $fn | grep "Apache License, Version 2" > /dev/null
  if [[ $? -ne 0 ]]; then
    echo "${fn} missing license"
    ret=$(($ret+1))
  fi

  head -20 $fn | grep Copyright > /dev/null
  if [[ $? -ne 0 ]]; then
    echo "${fn} missing Copyright"
    ret=$(($ret+1))
  fi
done

exit $ret
