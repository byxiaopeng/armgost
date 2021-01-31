#!/bin/bash
if [ ! -e '/elecV2P/script/Shell/scripts/jd_crazy_joy_coin.js' ]; then
    cp -r /tmp/Shell/scripts /elecV2P/script/Shell
    echo "拷贝仓库代码"
fi
if [ ! -e '/elecV2P/script/JSFile/deletelog.js' ]; then
    mv /deletelog.js /elecV2P/script/JSFile/deletelog.js
    echo "拷贝删除日志Js"
fi


if [ ! -e '/elecV2P/script/Shell/gx.sh' ]; then
    mv /gx.sh /elecV2P/script/Shell/gx.sh
    echo "拷贝更新代码"
fi
if [ ! -e '/elecV2P/script/Lists/task.list' ]; then
    mv /task.list /elecV2P/script/Lists/task.list
    echo "拷贝定时任务"
fi
node /elecV2P/script/Shell/scripts/jd_crazy_joy_coin.js >/dev/null 2>&1 &
echo "启动jd_crazy_joy_coin挂机完成"
/usr/sbin/sshd
echo "启动SSH成功"
cd /elecV2P && yarn start
