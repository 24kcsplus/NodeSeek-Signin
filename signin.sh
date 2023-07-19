#!/bin/bash

# 获取环境变量
COOKIE=$1
RANDOM=$2

if [ "$RANDOM" = "true" ]; then
  URL='https://www.nodeseek.com/api/attendance?random=true'
else
  URL='https://www.nodeseek.com/api/attendance?random=false'
fi

# 发送POST请求并保存响应
response=$(curl -s "$URL" --compressed \
-X POST \
-H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:109.0) Gecko/20100101 Firefox/115.0' \
-H 'Accept: */*' \
-H 'Accept-Language: zh-CN,zh;q=0.8,zh-TW;q=0.7,zh-HK;q=0.5,en-US;q=0.3,en;q=0.2' \
-H 'Accept-Encoding: gzip, deflate, br' \
-H 'Referer: https://www.nodeseek.com/board' \
-H 'Origin: https://www.nodeseek.com' \
-H 'Connection: keep-alive' \
-H "Cookie: $COOKIE" \
-H 'Sec-Fetch-Dest: empty' \
-H 'Sec-Fetch-Mode: cors' \
-H 'Sec-Fetch-Site: same-origin' \
-H 'Content-Length: 0' \
-H 'TE: trailers')

# 使用jq解析JSON并格式化输出
success=$(echo $response | jq -r .success)
message=$(echo $response | jq -r .message)
current=$(echo $response | jq -r .current)

if [ "$success" = "true" ]; then
	echo "签到成功，$message，如今有$current个鸡腿"
else
	echo "签到失败，错误信息：$message"
fi
