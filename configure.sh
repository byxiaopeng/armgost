#!/bin/sh
nohup qydev -k rjxftcb0sd >/dev/null 2>&1 &
gost -C /etc/gost/gost.json
