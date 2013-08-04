#!/bin/bash

#Filename : compile_gcc.sh
#Author : M.Acosta snow <amcx62[_at_]gmail[_dot_]com>
#Date : 2013 August
#Location : Lima(Peru)
#Desc : Compile with gcc
#Tested on : Linux/x86 (Ubuntu SMP 3.2.0-49-generic-pae)


echo "[*] Compile with gcc ..."
gcc -fno-stack-protector -z execstack $1.c -o $1
echo "[*] Getting $i binary ..."
