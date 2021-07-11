FROM alpine
RUN set -ex \
        && apk update && apk upgrade \
        && apk add tzdata git bash nodejs npm curl wget coreutils openssh-client \
        && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
        && echo "Asia/Shanghai" > /etc/timezone
        #&& mkdir -p /root/.ssh \
        #&& echo -e $KEY > /root/.ssh/id_rsa \
        #&& chmod 600 /root/.ssh/id_rsa \
        #&& ssh-keyscan gitee.com > /root/.ssh/known_hosts \
#RUN git clone -b $REPO_BRANCH $REPO_URL /tmp/jd
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
#拷贝Shell目录
RUN cp -r /usr/local/app/script/Shell /tmp
ENV PATH /usr/local/app/node_modules/.bin:$PATH
#添加变量
ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT /entrypoint.sh
