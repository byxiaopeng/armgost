FROM arm64v8/alpine

RUN apk update
RUN apk upgrade
RUN apk add --no-cache --virtual .build-deps ca-certificates wget curl
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

VOLUME /etc/gost

ADD configure.sh /configure.sh
RUN chmod +x /configure.sh
ENTRYPOINT /configure.sh
EXPOSE 1080
