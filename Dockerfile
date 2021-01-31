FROM alpine


RUN set -ex \
        && apk update && apk upgrade\
        && apk add --no-cache tzdata openssh curl moreutils git jq vim zip nodejs npm bash perl wget tzdata \
        && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
        && echo "Asia/Shanghai" > /etc/timezone
RUN sed -i "s/#PermitRootLogin.*/PermitRootLogin yes/g" /etc/ssh/sshd_config
RUN ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key
RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key
RUN echo "root:Qq123456" | chpasswd

RUN git clone https://github.com/elecV2/elecV2P.git \
        && cd /elecV2P \
        && yarn install --prod
EXPOSE 22 80 8001 8002

CMD ["node", "index.js"]
