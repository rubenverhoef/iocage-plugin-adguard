#!/bin/bash

# Installation
cd /root

if [ ! -d "/root/AdGuardHome" ]; then
    git clone https://github.com/AdguardTeam/AdGuardHome
fi

cd /root/AdGuardHome
git reset --hard
git checkout master
git pull
git checkout $(git describe --abbrev=0)

# Fix FreeBSD issue
if [ -f "/root/AdGuardHome/home/os_unix.go" ]; then
    sed -i -e 's/rlim.Max = uint64(val)/rlim.Max = int64(val)/g' /root/AdGuardHome/home/os_unix.go
    sed -i -e 's/rlim.Cur = uint64(val)/rlim.Cur = int64(val)/g' /root/AdGuardHome/home/os_unix.go
elif [ -f "/root/AdGuardHome/os_unix.go" ]; then
    sed -i -e 's/rlim.Max = uint64(val)/rlim.Max = int64(val)/g' /root/AdGuardHome/os_unix.go
    sed -i -e 's/rlim.Cur = uint64(val)/rlim.Cur = int64(val)/g' /root/AdGuardHome/os_unix.go
fi

make
