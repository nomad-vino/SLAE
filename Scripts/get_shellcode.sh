#!/bin/bash

#Filename : get_shellcode.sh
#Author : M.Acosta snow <amcx62[_at_]gmail[_dot_]com>
#Date : 2013 August
#Location : Lima(Peru)
#Desc : Get shellcode with objdump
#Tested on : Linux/x86 (Ubuntu SMP 3.2.0-49-generic-pae)

echo '[+] Getting shellcode with objdump ... '
for i in $(objdump -d $1 |grep "^ " |cut -f2); do echo -n '\x'$i; done;echo
echo '[+] Done! '
