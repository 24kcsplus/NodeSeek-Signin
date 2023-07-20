#!/bin/bash

IFS=$'\n'
COOKIES=($COOKIE)

for COOKIE in ${COOKIES[@]}; do
  if [ "$Random" = "true" ]; then
    response=$(curl -s 'https://www.nodeseek.com/api/attendance?random=true' --compressed -X POST \
      -H "Cookie: $COOKIE" \
      ...)

    echo "Response: $response"  # Print the response

    success=$(echo $response | jq -r .success)
    message=$(echo $response | jq -r .message)
    current=$(echo $response | jq -r .current)

    if [ "$success" = "true" ]; then
      echo "签到成功，$message，如今有$current个鸡腿"
    else
      echo "签到失败，错误信息：$message"
    fi
  else
    response=$(curl 'https://www.nodeseek.com/api/attendance?random=false' --compressed -X POST \
      -H "Cookie: $COOKIE" \
      ...)

    echo "Response: $response"  # Print the response

    success=$(echo $response | jq -r '.success')
    if [ "$success" = true ] ; then
      message=$(echo $response | jq -r '.message')
      gain=$(echo $response | jq -r '.gain')
      current=$(echo $response | jq -r '.current')
      echo "签到成功，$message，如今有$current 个鸡腿"
    else
      echo "签到失败，错误信息：$message"
    fi
  fi
done
