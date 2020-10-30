FROM arm64v8/alpine

RUN apk update
RUN apk upgrade
RUN apk add --no-cache --virtual .build-deps ca-certificates wget curl bash
#同步系统时间
RUN apk add tzdata
RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN echo "Asia/Shanghai" > /etc/timezone
RUN apk del tzdata

RUN mkdir /etc/gost
RUN wget -P /etc/gost https://github.com/ginuerzh/gost/releases/download/v2.11.1/gost-linux-armv8-2.11.1.gz
RUN gunzip /etc/gost/gost-linux-armv8-2.11.1.gz
RUN chmod +x /etc/gost/gost-linux-armv8-2.11.1
RUN mv /etc/gost/gost-linux-armv8-2.11.1 /usr/bin/gost

RUN wget https://qydev.com/client/qydev_linux_arm64
RUN chmod +x /qydev_linux_arm64
RUN mv /qydev_linux_arm64 /usr/bin/qydev

VOLUME /etc/gost

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT /entrypoint.sh
EXPOSE 1080
