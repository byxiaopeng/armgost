#!/bin/bash
echo "拷贝仓库代码"
if [ ! -e '/elecV2P/script/Shell/scripts/jd_crazy_joy_coin.js' ]; then
    cp -r /tmp/Shell/scripts /elecV2P/script/Shell
fi
echo "拷贝删除日志Js"
if [ ! -e '/elecV2P/script/JSFile/deletelog.js' ]; then
    mv /deletelog.js /elecV2P/script/JSFile/deletelog.js
fi

echo "拷贝更新代码"
if [ ! -e '/elecV2P/script/Shell/gx.sh' ]; then
    mv /gx.sh /elecV2P/script/Shell/gx.sh
fi
echo "拷贝定时任务"
if [ ! -e '/elecV2P/script/Lists/task.list' ]; then
    mv /task.list /elecV2P/script/Lists/task.list
fi
node /elecV2P/script/Shell/scripts/jd_crazy_joy_coin.js >/dev/null 2>&1 &
echo "启动jd_crazy_joy_coin挂机完成"
cd /elecV2P && yarn start
