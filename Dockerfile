FROM alpine
ENV REPO_URL=git@gitee.com:lxk0301/jd_scripts.git \
    REPO_BRANCH=master
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories
RUN set -ex \
        && apk update && apk upgrade \
        && apk add tzdata git bash nodejs npm curl wget screen openssh-client \
        #&& npm i -g npm to update \
        && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
        && echo "Asia/Shanghai" > /etc/timezone
RUN git clone https://github.com/elecV2/elecV2P.git /usr/local/app
RUN sed -i "s/60000/0/g" /usr/local/app/func/exec.js
RUN rm -r /usr/local/app/script/Lists/task.list
RUN cd /usr/local/app && npm install
WORKDIR /usr/local/app
EXPOSE 80 8001 8002
#拷贝JSFile目录
RUN cp -r /usr/local/app/script/JSFile /tmp
#拷贝lists目录
RUN cp -r /usr/local/app/script/Lists /tmp
ENV PATH /usr/local/app/node_modules/.bin:$PATH
#添加变量
ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT /entrypoint.sh
