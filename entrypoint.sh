#!/bin/bash
if [ ! -e '/elecV2P/script/Shell/scripts/jd_crazy_joy_coin.js' ]; then
    cp -r /tmp/Shell/scripts /elecV2P/script/Shell
    echo "拷贝仓库代码"
fi
if [ ! -e '/elecV2P/script/JSFile/deletelog.js' ]; then
    mv /deletelog.js /elecV2P/script/JSFile/deletelog.js
    echo "拷贝删除日志Js"
fi


if [ ! -e '/elecV2P/script/Lists/useragent.list' ]; then
    cp -r /tmp/Lists /elecV2P/script
    echo "拷贝Lists代码"
fi

if [[ ${ENABLE_HANGUP} == true ]]; then
    node /elecV2P/script/Shell/scripts/jd_crazy_joy_coin.js >/dev/null 2>&1 &
    echo -e "启动joy挂机程序"
elif [[ ${ENABLE_HANGUP} == false ]]; then
  echo -e "设置不挂机joy，跳过"
fi
#node /elecV2P/script/Shell/scripts/jd_crazy_joy_coin.js >/dev/null 2>&1 &
#echo "启动jd_crazy_joy_coin挂机完成"
cd /elecV2P && pm2 start index.js
tail -f /dev/null
