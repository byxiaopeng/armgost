#!/bin/bash
echo "开始执行更新仓库代码"
cd /elecV2P/script/Shell/scripts
git reset --hard
git -C /elecV2P/script/Shell/scripts pull --rebase
jdpid=$(ps -ef | grep "jd_crazy" | awk '{print $1}')
echo "进程pid=$jdpid"
kill $jdpid
echo "配置jd_crazy_joy_coin重启完成"
node /elecV2P/script/Shell/scripts/jd_crazy_joy_coin.js >/dev/null 2>&1 &
echo "启动jd_crazy_joy_coin挂机完成"