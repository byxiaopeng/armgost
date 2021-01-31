FROM arm64v8/node:alpine

RUN set -ex \
        && apk update && apk upgrade\
        && apk add --no-cache tzdata curl moreutils git jq vim zip bash perl wget \
        && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
        && echo "Asia/Shanghai" > /etc/timezone

RUN git clone https://github.com/elecV2/elecV2P.git \
        && cd /elecV2P \
        && yarn install --prod
WORKDIR /elecV2P
EXPOSE 80 8001 8002

#CMD ["yarn", "start"]
ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT /entrypoint.sh
