#!/bin/sh


cd / && curl -s https://api.github.com/repos/AdguardTeam/AdGuardHome/releases/latest | grep "AdGuardHome_freebsd_amd64.tar.gz" | cut -d : -f 2,3 | tr -d \" | wget -qi -
tar -xvzf AdGuardHome*.tar.gz -C /root
rm AdGuardHome*.tar.gz

chmod +x /usr/local/etc/rc.d/adguard
sysrc 'adguard_enable=YES'
service adguard start
