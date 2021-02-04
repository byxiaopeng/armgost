#FROM node:alpine
FROM alpine
RUN set -ex \
        && apk update && apk upgrade\
        && apk add --no-cache yarn tzdata curl moreutils git jq vim zip bash perl wget \
        && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
        && echo "Asia/Shanghai" > /etc/timezone
RUN sed -i "s/#PermitRootLogin.*/PermitRootLogin yes/g" /etc/ssh/sshd_config
RUN ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key
RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key
RUN echo "root:Qq123456" | chpasswd
RUN git clone https://github.com/elecV2/elecV2P.git \
        && cd /elecV2P \
        && yarn \
        && yarn global add pm2
        #yarn install --prod
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
