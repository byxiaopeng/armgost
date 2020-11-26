FROM arm64v8/alpine

RUN apk update
RUN apk upgrade
RUN apk add --no-cache --virtual .build-deps ca-certificates openssh wget curl bash
#同步系统时间
RUN apk add tzdata
RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN echo "Asia/Shanghai" > /etc/timezone
RUN apk del tzdata

RUN sed -i "s/#PermitRootLogin.*/PermitRootLogin yes/g" /etc/ssh/sshd_config
RUN ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key
RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key
RUN echo "root:admin" | chpasswd

RUN mkdir /etc/gost
RUN wget -P /etc/gost https://github.com/ginuerzh/gost/releases/download/v2.11.1/gost-linux-armv8-2.11.1.gz
RUN gunzip /etc/gost/gost-linux-armv8-2.11.1.gz
RUN chmod +x /etc/gost/gost-linux-armv8-2.11.1
RUN mv /etc/gost/gost-linux-armv8-2.11.1 /usr/bin/gost

VOLUME /etc/gost

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT /entrypoint.sh
EXPOSE 22 1080
