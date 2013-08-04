#!/bin/bash

#Filename : compile_asm.sh
#Author : M.Acosta snow <amcx62[_at_]gmail[_dot_]com>
#Date : 2013 August
#Location : Lima(Peru)
#Desc : Assembling with NASM and ld
#Tested on : Linux/x86 (Ubuntu SMP 3.2.0-49-generic-pae)

echo '[+] Assembling with NASM ... '
nasm -f elf32 -o $1.o $1.asm

echo '[+] Linking ...'
ld -o $1 $1.o

echo '[+] Done!'
