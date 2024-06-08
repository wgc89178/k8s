#!/bin/bash

cd /root/.jenkins/workspace/t06
docker build -t 172.26.240.210/library/nginx:1.30.2 .
docker push 172.26.240.210/library/nginx:1.30.2

echo '打包上传成功'

