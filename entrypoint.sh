#!/bin/bash
node /elecV2P/Shell/scripts/jd_crazy_joy_coin.js >/dev/null 2>&1 &
echo "启动jd_crazy_joy_coin挂机完成"
cd /elecV2P && yarn start
