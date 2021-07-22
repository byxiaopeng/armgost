FROM alpine
RUN set -ex \
        && apk update && apk upgrade \
        && apk add tzdata git bash nodejs-current npm curl wget coreutils openssh-client \
        && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
        && echo "Asia/Shanghai" > /etc/timezone \
        && git clone https://github.com/elecV2/elecV2P.git /usr/local/app \
        && sed -i "s/60000/0/g" /usr/local/app/func/exec.js \
        && rm -r /usr/local/app/script/Lists/task.list \
        && cd /usr/local/app \
        && npm install
WORKDIR /usr/local/app
EXPOSE 80 8001 8002
#拷贝JSFile目录
RUN cp -r /usr/local/app/script/JSFile /tmp
#拷贝lists目录
RUN cp -r /usr/local/app/script/Lists /tmp
#拷贝Shell目录
RUN cp -r /usr/local/app/script/Shell /tmp
ENV PATH /usr/local/app/node_modules/.bin:$PATH
#添加变量
ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT /entrypoint.sh
