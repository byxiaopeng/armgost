#!/bin/bash
if [ ! -e '/elecV2P/script/Shell/scripts/jd_crazy_joy_coin.js' ]; then
    cp -r /tmp/Shell/scripts /elecV2P/script/Shell
    echo "拷贝仓库代码"
fi
if [ ! -e '/elecV2P/script/JSFile/0body.js' ]; then
    cp -r /tmp/JSFile /elecV2P/script
    echo "拷贝JSFile代码"
fi

if [ ! -e '/elecV2P/script/Lists/task.list' ]; then
    cp -r /tmp/Lists /elecV2P/script
    wget -P /elecV2P/script/Lists -q https://www.armn1.ml/jiaoben/task.list
    echo "拷贝Lists代码"
fi


if [ ! -e '/elecV2P/script/Shell/gx.sh' ]; then
    mv /gx.sh /elecV2P/script/Shell/gx.sh
    echo "拷贝更新代码"
fi
echo "开始判断是否挂机joy"
if [[ ${ENABLE_HANGUP} == true ]]; then
    jdpid=$(ps -ef | grep "jd_crazy" | awk '{print $1}')
    echo "joy进程pid=$jdpid"
    kill $jdpid
    echo "配置jd_crazy_joy_coin重启完成"
    node /elecV2P/script/Shell/scripts/jd_crazy_joy_coin.js >/dev/null 2>&1 &
    echo "启动jd_crazy_joy_coin挂机完成"
elif [[ ${ENABLE_HANGUP} == false ]]; then
  echo -e "没有设置变量为true  不执行joy挂机"
fi
cd /elecV2P && pm2 start index.js --name elecV2P
tail -f /dev/null
