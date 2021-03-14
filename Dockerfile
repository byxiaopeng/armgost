FROM alpine
ENV REPO_URL=git@gitee.com:lxk0301/jd_scripts.git \
    REPO_BRANCH=master
ARG KEY="-----BEGIN OPENSSH PRIVATE KEY-----\nb3BlbnNzaC1rZXktdjEAAAAABG5vbmUAAAAEbm9uZQAAAAAAAAABAAABFwAAAAdzc2gtcn\nNhAAAAAwEAAQAAAQEAvRQk2oQqLB01iVnJKrnI3tTfJyEHzc2ULVor4vBrKKWOum4dbTeT\ndNWL5aS+CJso7scJT3BRq5fYVZcz5ra0MLMdQyFL1DdwurmzkhPYbwcNrJrB8abEPJ8ltS\nMoa0X9ecmSepaQFedZOZ2YeT/6AAXY+cc6xcwyuRVQ2ZJ3YIMBrRuVkF6nYwLyBLFegzhu\nJJeU5o53kfpbTCirwK0h9ZsYwbNbXYbWuJHmtl5tEBf2Hz+5eCkigXRq8EhRZlSnXfhPr2\n32VCb1A/gav2/YEaMPSibuBCzqVMVruP5D625XkxMdBdLqLBGWt7bCas7/zH2bf+q3zac4\nLcIFhkC6XwAAA9BjE3IGYxNyBgAAAAdzc2gtcnNhAAABAQC9FCTahCosHTWJWckqucje1N\n8nIQfNzZQtWivi8GsopY66bh1tN5N01YvlpL4ImyjuxwlPcFGrl9hVlzPmtrQwsx1DIUvU\nN3C6ubOSE9hvBw2smsHxpsQ8nyW1IyhrRf15yZJ6lpAV51k5nZh5P/oABdj5xzrFzDK5FV\nDZkndggwGtG5WQXqdjAvIEsV6DOG4kl5TmjneR+ltMKKvArSH1mxjBs1tdhta4kea2Xm0Q\nF/YfP7l4KSKBdGrwSFFmVKdd+E+vbfZUJvUD+Bq/b9gRow9KJu4ELOpUxWu4/kPrbleTEx\n0F0uosEZa3tsJqzv/MfZt/6rfNpzgtwgWGQLpfAAAAAwEAAQAAAQEAnMKZt22CBWcGHuUI\nytqTNmPoy2kwLim2I0+yOQm43k88oUZwMT+1ilUOEoveXgY+DpGIH4twusI+wt+EUVDC3e\nlyZlixpLV+SeFyhrbbZ1nCtYrtJutroRMVUTNf7GhvucwsHGS9+tr+96y4YDZxkBlJBfVu\nvdUJbLfGe0xamvE114QaZdbmKmtkHaMQJOUC6EFJI4JmSNLJTxNAXKIi3TUrS7HnsO3Xfv\nhDHElzSEewIC1smwLahS6zi2uwP1ih4fGpJJbU6FF/jMvHf/yByHDtdcuacuTcU798qT0q\nAaYlgMd9zrLC1OHMgSDcoz9/NQTi2AXGAdo4N+mnxPTHcQAAAIB5XCz1vYVwJ8bKqBelf1\nw7OlN0QDM4AUdHdzTB/mVrpMmAnCKV20fyA441NzQZe/52fMASUgNT1dQbIWCtDU2v1cP6\ncG8uyhJOK+AaFeDJ6NIk//d7o73HNxR+gCCGacleuZSEU6075Or2HVGHWweRYF9hbmDzZb\nCLw6NsYaP2uAAAAIEA3t1BpGHHek4rXNjl6d2pI9Pyp/PCYM43344J+f6Ndg3kX+y03Mgu\n06o33etzyNuDTslyZzcYUQqPMBuycsEb+o5CZPtNh+1klAVE3aDeHZE5N5HrJW3fkD4EZw\nmOUWnRj1RT2TsLwixB21EHVm7fh8Kys1d2ULw54LVmtv4+O3cAAACBANkw7XZaZ/xObHC9\n1PlT6vyWg9qHAmnjixDhqmXnS5Iu8TaKXhbXZFg8gvLgduGxH/sGwSEB5D6sImyY+DW/OF\nbmIVC4hwDUbCsTMsmTTTgyESwmuQ++JCh6f2Ams1vDKbi+nOVyqRvCrAHtlpaqSfv8hkjK\npBBqa/rO5yyYmeJZAAAAFHJvb3RAbmFzLmV2aW5lLnByZXNzAQIDBAUG\n-----END OPENSSH PRIVATE KEY-----"
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories
RUN set -ex \
        && apk update && apk upgrade \
        && apk add tzdata git bash openssh-client \
        #&& npm i -g npm to update \
        && mkdir -p /root/.ssh \
        && echo -e $KEY > /root/.ssh/id_rsa \
        && chmod 600 /root/.ssh/id_rsa \
        && ssh-keyscan gitee.com > /root/.ssh/known_hosts \
        && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
        && echo "Asia/Shanghai" > /etc/timezone
RUN git clone -b $REPO_BRANCH $REPO_URL /tmp/Shell/scripts

RUN git clone https://github.com/elecV2/elecV2P.git /usr/local/app
RUN sed -i "s/60000/0/g" /usr/local/app/func/exec.js
RUN rm -r /usr/local/app/script/Lists/task.list
RUN rm -r /usr/local/app/package.json
ADD package.json /usr/local/app/package.json

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
