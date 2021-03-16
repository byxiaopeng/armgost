#!/bin/bash
case $TYPE in
"git")
  rm -r /usr/local/app/script/Store/cookieKEY
  rm -r /usr/local/app/script/Store/newone
  git clone ${GIT_URL} /usr/local/app/script/Store
  echo "usr/local/app/script/Store目录"
  break
  ;;
esac
if [ ! -e '/usr/local/app/script/Shell/scripts/jdCookie.js' ]; then
    cp -r /tmp/Shell/scripts /usr/local/app/script/Shell
    cd /usr/local/app/script/Shell/scripts && npm install
    echo "拷贝仓库代码并安装依赖"
fi
if [ ! -e '/usr/local/app/script/JSFile/0body.js' ]; then
    cp -r /tmp/JSFile /usr/local/app/script
    echo "拷贝JSFile代码"
fi

if [ ! -e '/usr/local/app/script/Lists/task.list' ]; then
    cp -r /tmp/Lists /usr/local/app/script
    wget -P /usr/local/app/script/Lists -q https://raw.cnm.workers.dev/gossh520/cdcs/main/task.list
    echo "拷贝Lists代码"
fi
cd /usr/local/app && pm2 start index.js --name elecV2P
tail -f /dev/null
