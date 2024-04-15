#!/bin/bash

cewl -m 8 -d 8 -w /home/kali/wordlist-metasploitable3-phpmyadmin.txt https://github.com/rapid7/metasploitable3/
msfconsole -qr /home/kali/baw/attacks_conf/ 
