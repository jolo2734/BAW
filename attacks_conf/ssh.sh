#!/bin/bash

cewl -m 7 -d 0 -w /home/kali/wordlist-metasploitable3.txt https://github.com/rapid7/metasploitable3/
msfconsole -qr /home/kali/baw/attacks_conf/ssh.rc
