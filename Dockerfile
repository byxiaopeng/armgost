FROM alpine
RUN set -ex \
        && apk update && apk upgrade\
        && apk add --no-cache yarn tzdata curl moreutils git jq vim bash perl wget python3 python3-pip py3-cryptography \
        && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
        && echo "Asia/Shanghai" > /etc/timezone
RUN git clone https://github.com/elecV2/elecV2P.git \
        && cd /elecV2P \
        && sed -i "s/60000/86400000/g" /elecV2P/func/exec.js \
        && yarn \
        && yarn global add pm2
#修改Shell超时时间为一天
RUN git clone https://gitee.com/lxk0301/jd_scripts.git /tmp/Shell/scripts \
        && cd /tmp/Shell/scripts \
        && git checkout master \
        && yarn
        #&& npm install
WORKDIR /elecV2P
EXPOSE 80 8001 8002
RUN mv /elecV2P/script/JSFile/deletelog.js /deletelog.js
RUN cp -r /elecV2P/script/Lists /tmp
#CMD ["yarn", "start"]
ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT /entrypoint.sh
