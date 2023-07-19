#!/bin/bash
IFS=$'\n' read -d '' -r -a lines <<< "$1"
OUTPUT=""
for COOKIE in "${lines[@]}"
do
  if [ "$RANDOM" == "true" ]; then
    MESSAGE=$(curl -H "cookie:$COOKIE" -H 'content-type:application/json;charset=UTF-8' -d '{"token": "nodeseek.com"}' -X POST 'https://www.nodeseek.com/api/attendance?random=true' | grep -Eo '"message":"[^"]*"')
  else
    MESSAGE=$(curl -H "cookie:$COOKIE" -H 'content-type:application/json;charset=UTF-8' -d '{"token": "nodeseek.com"}' -X POST 'https://www.nodeseek.com/api/attendance?random=false' | grep -Eo '"message":"[^"]*"')
  fi
  OUTPUT+="$MESSAGE   "
  STATUS=$(curl -H "cookie:$COOKIE" -X GET 'https://www.nodeseek.com/api/user/status' | grep -Eo '"leftDays":"[^"]*"')
  OUTPUT+="$STATUS   "
done
echo "$OUTPUT"
