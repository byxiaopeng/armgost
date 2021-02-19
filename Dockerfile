FROM alpine
RUN set -ex \
        && apk update && apk upgrade \
        && apk add tzdata curl moreutils git jq bash perl wget yarn npm \
        && apk add python python3 py3-pip py3-cryptography \
        && npm i -g npm to update \
        && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
        && echo "Asia/Shanghai" > /etc/timezone
      
RUN git clone https://gitee.com/lxk0301/jd_scripts.git /tmp/Shell/scripts \
        && cd /tmp/Shell/scripts \
        && git checkout master
        #&& yarn
        #&& npm install
RUN git clone https://github.com/elecV2/elecV2P.git \
        && sed -i "s/60000/86400000/g" /elecV2P/func/exec.js \
        && rm -r /elecV2P/package.json
        #&& yarn global add pm2
#修改Shell超时时间为一天
add package.json /elecV2P/package.json
RUN cd /elecV2P && npm install

RUN pip3 install requests rsa beautifulsoup4
#安装PY3的一些支持库
WORKDIR /elecV2P
EXPOSE 80 8001 8002
#拷贝JSFile目录
RUN cp -r /elecV2P/script/JSFile /tmp
#拷贝lists目录
RUN cp -r /elecV2P/script/Lists /tmp

ENV PATH /elecV2P/node_modules/.bin:$PATH
#添加变量
ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT /entrypoint.sh
