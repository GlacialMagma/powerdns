Configuration summary
=====================

 Configured with:  '--with-dynmodules=geoip godbc gpgsql gsqlite3 ldap mydns pipe remote tinydns' '--without-lua' '--sysconfdir=/etc/pdns'

 CC: gcc
 CXX: g++
 LD: /usr/bin/ld -m elf_x86_64
 CFLAGS: -fPIE -DPIE -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=2 --param ssp-buffer-size=4 -fstack-protector -Wall -g -O2
 CPPFLAGS:
 CXXFLAGS:  -fPIE -DPIE -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=2 --param ssp-buffer-size=4 -fstack-protector -Wall -g -O2
 LDFLAGS: -Wl,-z -Wl,relro -Wl,-z -Wl,now
 LIBS:
 BOOST_CPPFLAGS:

 Features enabled
 ----------------
 Built-in modules: bind gmysql random
 Dynamic modules: geoip godbc gpgsql gsqlite3 ldap mydns pipe remote tinydns

 OpenSSL ecdsa: yes
 ed25519: yes
 ed448: no
 gost: no
 SQLite3: yes
 Lua/LuaJit: no
 systemd: no
