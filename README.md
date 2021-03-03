# elecv2p-jd

部署docker

基础镜像：byxiaopeng/elecv2p

``` sh

# 推荐使用命令
docker run --restart=always \
  -d --name elecv2p \
  -p 80:80 -p 8001:8001 -p 8002:8002 \
  -v /elecv2p/JSFile:/elecV2P/script/JSFile \
  -v /elecv2p/Lists:/elecV2P/script/Lists \
  -v /elecv2p/Store:/elecV2P/script/Store \
  -v /elecv2p/Shell:/elecV2P/script/Shell \
  -v /elecv2p/rootCA:/elecV2P/rootCA \
  -v /elecv2p/efss:/elecV2P/efss \
  -v /elecv2p/logs:/elecV2P/logs \
  byxiaopeng/elecv2pjd

# 升级 Docker 镜像。（如果没有使用持久化存储，升级后所有个人数据会丢失，请提前备份）
docker rm -f elecv2p           # 先删除旧的容器
docker pull byxiaopeng/elecv2p     # 再下载新的镜像。镜像名注意要和之前使用的相对应
# 再使用之前的 docker run xxxx 命令重新启动一下
```
使用教程请参考
https://github.com/elecV2/elecV2P-dei/tree/master/docs
