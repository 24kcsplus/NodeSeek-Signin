#!/bin/bash

IFS=$'\n'
COOKIES=($COOKIE)

for COOKIE in ${COOKIES[@]}; do
  if [ "$Random" = "true" ]; then
    response=$(curl -s 'https://www.nodeseek.com/api/attendance?random=true' --compressed -X POST \
      -H "Cookie: $COOKIE" \
      ...)

    echo "Response: $response"  # Print the response

    success=$(echo $response | jq -r .success 2>/dev/null)
    if [ "$success" = "true" ]; then
      message=$(echo $response | jq -r .message 2>/dev/null)
      current=$(echo $response | jq -r .current 2>/dev/null)
      echo "签到成功，$message，如今有$current个鸡腿"
    else
      echo "签到失败，错误信息：$response"
    fi
  else
    response=$(curl 'https://www.nodeseek.com/api/attendance?random=false' --compressed -X POST \
      -H "Cookie: $COOKIE" \
      ...)

    echo "Response: $response"  # Print the response

    success=$(echo $response | jq -r '.success' 2>/dev/null)
    if [ "$success" = true ] ; then
      message=$(echo $response | jq -r '.message' 2>/dev/null)
      gain=$(echo $response | jq -r '.gain' 2>/dev/null)
      current=$(echo $response | jq -r '.current' 2>/dev/null)
      echo "签到成功，$message，如今有$current 个鸡腿"
    else
      echo "签到失败，错误信息：$response"
    fi
  fi
done
